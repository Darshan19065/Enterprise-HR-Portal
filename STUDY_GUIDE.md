# Enterprise HR Information System (HRIS)
### Official Study Guide & Defense Manual

This document is designed to help you and your project partner study the architecture, justify the technical choices, and easily answer any questions your teachers ask during the presentation.

---

## 1. Project Scope & Architecture
**What is this project?**
This is a Single-Page Application (SPA) designed as an Enterprise HR Portal. It handles 8 distinct modules: Dashboard Analytics, Project Kanban boards, Staff Roster viewing, Onboarding, Corporate Reviews, Daily Time Clocks, Employee Lookup searching, and a custom Paid-Time-Off (PTO) engine.

**Architecture Paradigm: MVC (Model-View-Controller)**
Even without a database, this project heavily respects the MVC software pattern:
- **Model:** The `com.employeemanagement.model` and `data` packages. This holds the physical structure of an Employee and the `ArrayList` RAM storage acting as our database.
- **View:** `index.jsp` and `style.css`. The frontend that the user actually sees.
- **Controller:** `DashboardServlet.java` and `ActionServlet.java`. The middle-men that intercept the button clicks from the View, do the math, update the Model, and return back to the View.

---

## 2. Technical Justifications (Answering "Why did you use...?")

### Why did you use JSP (JavaServer Pages)?
Instead of building a hyper-complex REST API and a decoupled React.js frontend, we used JSP because it allows us to forcefully inject Java variables directly into our HTML structure at the server level before the webpage is sent to the user. Using JSTL (JavaServer Pages Standard Tag Library) `<c:forEach>`, we can dynamically loop through backend Java `ArrayLists` and instantly generate complex HTML grids and Data Tables without needing complex REST API fetching.

### Why did you purposely not use MySQL / SQL Database?
To demonstrate a deep understanding of core Object-Oriented Java data structures! By utilizing static `ArrayLists` inside Singleton-style "Store" classes (like `EmployeeStore.java`), we achieve ultra-low latency, in-memory data processing. It proves we know how to write manual Data Access logic (Looping, Updating, iterators for deleting) without relying on SQL shortcuts.

### Why did you use Maven?
Java applications are notoriously difficult to compile manually, especially when they rely on external libraries (like JSTL) or Web Server environments (like Tomcat/Jetty). Maven acts as our "Build Automation Tool":
1. It automatically downloads JSTL dependencies from the internet (via `pom.xml`).
2. It compiles all out `.java` files into `.class` files in the exact `target` folder structure required for web applications.
3. It provides the **Jetty Plugin**, spinning up an instant `localhost:8080` HTTP server so we didn't have to manually download and install Apache Tomcat.

---

## 3. Directory & File Breakdown

### Root Configuration
- **`pom.xml`**: The brain of Maven. It defines what libraries the program needs (Servlet API, JSTL), and configures the Jetty Server plugin.
- **`mvnw` (Maven Wrapper)**: A brilliant script that allows someone to run the app without installing Maven on their system.

### The Backend (Java Classes)
Located in `src/main/java/com/employeemanagement/`

#### 1. Models (`/model`)
These are POJOs (Plain Old Java Objects). They act purely as data blueprints.
- **`Employee.java`**: Defines what an employee is. It leverages automatic math calculations via `getDailyAverage()` which handles division locally.
- **`Project.java`**: Blueprint for Kanban projects.
- **`Review.java`**: Blueprint for the 5-star review system.

#### 2. The Data Layer (`/data`)
These replace a MySQL database. They use `public static List` so the RAM remembers the data entirely across the server's lifecycle.
- **`EmployeeStore.java`**: Holds the array of 15 dummy employees. Contains all the logic loops: `addEmployee()`, `removeEmployee()` (uses an Iterator to scrub memory safely), and `logDailyTime()`.
- **`ProjectStore.java`**: Holds the projects and the `updateProjectStatus()` which allows the Kanban board to push projects between phases.

#### 3. The Controllers (`/servlet`)
Servlets are Java classes that "listen" to HTTP Requests from the browser.
- **`ActionServlet.java`**: The absolute workhorse. It listens to `doPost` requests. Every time you submit a form (Add Employee, Edit, Terminate, Assign PTO), the form has a hidden `actionType`. This Servlet grabs that action, runs a massive `if/else if`, manipulates the `Stores`, and immediately redirects the user back to the web page.
- **`DashboardServlet.java`**: The `doGet` loader. Whenever someone opens `localhost:8080`, this intercepts the request, grabs all arrays from the Data Layer, calculates massive logic like `Total Revenue`, binds them to strings (`request.setAttribute`), and forwards the user to `index.jsp`.
- **`CsvExportServlet.java`**: Mapped to `/export`. Instead of loading a web page, it overwrites the browser headers (`response.setContentType("text/csv")`), loops through the `EmployeeStore`, and literally prints out comma-separated data, forcing the user's browser to physically download a file.

### The Frontend (Web App)
Located in `src/main/webapp/`

- **`web.xml`**: The Web Deployment Descriptor. It officially maps `DashboardServlet.java` to load automatically when opening the `/` root folder.
- **`css/style.css`**: Features incredibly complex, responsive CSS Grids (for the Kanban board), specific `<c:....>` dynamically themed buttons, and the massive `:root[data-theme="dark"]` CSS Variables that instantly calculate the Dark Mode night-time inverse shifting. 
- **`index.jsp`**: The entire frontend. 
  - **Single Page App Logic**: It has 8 `<section>` blocks. Our Javascript hides all of them except the one you clicked on, providing instant tab-switching without webpage reloading.
  - **Chart.js**: Javascript loops through the Java arrays via `<c:forEach>` to generate physical JSON array lists. It passes that JSON to the external Chart.js library to instantly render the interactive pie chart.
  - **Sortable Javascript**: Contains an Algorithm that scans `<table>` structures. When you click a header, it pulls the `data-sort` attributes, compares the strings/numbers, and physically rearranges the DOM (Document Object Model) rows.
