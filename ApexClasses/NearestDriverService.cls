public with sharing class NearestDriverService {
    public class DriverRequest { 
        @InvocableVariable(required=true) public Id deliveryId; 
        @InvocableVariable public Decimal latitude; 
        @InvocableVariable public Decimal longitude;
        @InvocableVariable public Id hubId;
    }
    
    public class DriverResponse { 
        @InvocableVariable public Id driverId; 
        @InvocableVariable public Decimal estDistanceKm; 
        @InvocableVariable public Decimal estETAHours; 
    }

    @InvocableMethod(label='Find Nearest Driver' description='Find nearest available driver for deliveries')
    public static List<DriverResponse> findNearestDrivers(List<DriverRequest> requests) {
        List<DriverResponse> responses = new List<DriverResponse>();
        
        // Since this is called from a record-triggered flow, we expect 1 request
        if(requests == null || requests.isEmpty()) {
            return responses;
        }
        
        DriverRequest request = requests[0];
        
        // If coordinates aren't provided in the request, query them
        Decimal deliveryLat = request.latitude;
        Decimal deliveryLon = request.longitude;
        
        // If coordinates not provided, query the delivery record
        if(deliveryLat == null || deliveryLon == null) {
            Delivery__c delivery = [
                SELECT Id, Latitude__c, Longitude__c, Hub__c
                FROM Delivery__c 
                WHERE Id = :request.deliveryId
                LIMIT 1
            ];
            deliveryLat = delivery.Latitude__c;
            deliveryLon = delivery.Longitude__c;
        }
        
        // Check if we have valid coordinates
        if(deliveryLat == null || deliveryLon == null) {
            DriverResponse emptyResp = new DriverResponse();
            responses.add(emptyResp);
            return responses;
        }

        // Get all available drivers
        List<Driver__c> drivers = [
            SELECT Id, Current_Latitude__c, Current_Longitude__c, Status__c 
            FROM Driver__c 
            WHERE Status__c = 'Available'
            AND Current_Latitude__c != null 
            AND Current_Longitude__c != null
        ];

        DriverResponse response = new DriverResponse();
        Decimal minDist = Decimal.valueOf(999999);
        Id minDriverId;
        
        for(Driver__c driver : drivers) {
            Decimal dist = haversine(deliveryLat, deliveryLon, driver.Current_Latitude__c, driver.Current_Longitude__c);
            
            if(dist < minDist) {
                minDist = dist;
                minDriverId = driver.Id;
            }
        }
        
        if(minDriverId != null) {
            response.driverId = minDriverId;
            response.estDistanceKm = minDist.setScale(2);
            // Assume 30 km/h average speed for ETA calculation
            response.estETAHours = (minDist / 30).setScale(2);
        }
        
        responses.add(response);
        return responses;
    }

    // Haversine method to calculate distance between two lat/lon points
    public static Decimal haversine(Decimal lat1, Decimal lon1, Decimal lat2, Decimal lon2) {
        Decimal R = 6371; // Earth radius in km
        Decimal dLat = toRad(lat2 - lat1);
        Decimal dLon = toRad(lon2 - lon1);
        
        Decimal a = Math.sin(dLat/2) * Math.sin(dLat/2) + 
                   Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * 
                   Math.sin(dLon/2) * Math.sin(dLon/2);
        Decimal c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        
        return R * c;
    }

    public static Decimal toRad(Decimal deg) {
        return deg * Math.PI / 180;
    }
}