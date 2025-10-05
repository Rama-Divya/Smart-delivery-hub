# 🚚 **Smart Delivery Hub**

A Salesforce-based CRM solution designed to optimize last-mile delivery operations by automating driver assignment, estimating delivery time (ETA), and tracking performance through intuitive dashboards.

---

## 🧭 **Project Overview**

**Smart Delivery Hub** leverages Salesforce CRM capabilities to streamline the coordination between **hubs, drivers, and deliveries**.  
The system automatically assigns the nearest available driver to each delivery, calculates estimated delivery times, and provides real-time tracking and analytics through dashboards.

---

## 🎯 **Objectives**

- **Automate** driver assignment based on proximity and availability.  
- **Track** delivery progress, SLA breaches, and overall performance.  
- **Visualize** operations through interactive dashboards and reports.  
- **Enhance** decision-making using Salesforce CRM tools.

---

## ⚙️ **Key Features**

- **🚗 Auto Driver Assignment:** Automatically assigns nearest available drivers using Apex logic.  
- **⏱ ETA Calculation:** Estimates delivery time dynamically based on driver and customer locations.  
- **📊 Dashboards & Reports:** Track deliveries, on-time rates, and driver performance.  
- **🧍‍♂️ User Management:** Maintain driver, hub, and delivery data seamlessly.  
- **📢 Notifications & Status Tracking:** Real-time updates for delivery stages (Scheduled → Assigned → In Transit → Delivered).

---

## 🧩 **Data Model**

| Object | Description | Key Fields |
|--------|--------------|-------------|
| **Hub** | Represents delivery hubs or locations. | City, Hub Latitude, Hub Longitude |
| **Driver** | Stores driver details and availability. | Status, Capacity, Current Location |
| **Delivery** | Contains delivery order information. | Customer Details, Status, Assigned Driver, ETA |

---

## 💻 **Tech Stack**

- **Platform:** Salesforce Developer Edition  
- **Automation:** Flow Builder, Apex Triggers, Process Builder  
- **Languages:** Apex, SOQL  
- **Visualization:** Lightning Dashboard, Reports  
- **Data Handling:** Data Import Wizard  

---

## 🛠️ **System Architecture**

1. **Delivery Creation:** New delivery record created with status = `Scheduled`.  
2. **Auto-Assignment Flow:** Triggers Apex class `NearestDriverService` to find nearest available driver.  
3. **ETA & Distance Calculation:** Automatically populated fields in delivery record.  
4. **Status Tracking:** Updates from `Scheduled → Assigned → In Transit → Delivered`.  
5. **Reports & Dashboards:** Provide performance insights to admins and managers.

---

## ⚡ **Automation Components**

| Component | Description |
|------------|-------------|
| **NearestDriverService (Apex Class)** | Finds nearest available driver based on coordinates. |
| **Auto Assign Driver (Flow)** | Triggered on new delivery creation to assign driver. |
| **Delivery Operations Dashboard** | Visualizes key metrics and KPIs. |

---

## 📊 **Reports & Dashboards**

- **Delivery Summary Report** → Group by delivery status.  
- **Driver Performance Report** → Average delivery time per driver.  
- **SLA Breach Report** → Identify delayed or failed deliveries.  
- **Dashboard Components:** Total Deliveries, On-Time %, Deliveries by Status, Overdue List.

---

## 🔧 **Installation & Setup**

### **Step 1:** Create Salesforce Developer Org  
Visit [developer.salesforce.com](https://developer.salesforce.com) → Sign Up → Verify email.

### **Step 2:** Create Custom Objects  
Objects: **Hub**, **Driver**, **Delivery** with required fields (as listed in project guide).

### **Step 3:** Import Data  
Use **Data Import Wizard** to import `hubs.csv`, `drivers.csv`, and `deliveries.csv`.

### **Step 4:** Deploy Apex & Flow  
- Create **NearestDriverService** class in Apex.  
- Build **Record-Triggered Flow** named *Auto Assign Driver*.  

### **Step 5:** Activate App  
- Create a Lightning App → Add tabs for Deliveries, Drivers, and Hubs.  
- Customize record pages with Quick Actions and related lists.

---

## 🧪 **Testing Scenarios**

✅ Create new delivery → Automatically assigns nearest driver.  
✅ Check ETA → Populates correctly based on distance.  
✅ Change delivery status → Progresses through lifecycle.  
✅ Dashboard → Reflects updated delivery metrics.

---

## 🎥 **Demo & Walkthrough**

- **Demo Video:** (Add your Loom/YouTube link here)  
- **Features Shown:**  
  - Delivery Auto Assignment  
  - ETA Calculation  
  - Dashboard Analytics  
  - Driver & Delivery Management  

---

## 🗂️ **Repository Structure**

SmartDeliveryHub/
├── ApexClasses/
│ └── NearestDriverService.cls
├── Data/
│ ├── drivers.csv
│ ├── hubs.csv
│ └── deliveries.csv
├── Flows/
│ └── Auto_Assign_Driver.jpg
├── Screenshots/
│ └── dashboard.jpg
└── README.md
