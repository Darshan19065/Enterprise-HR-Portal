<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System V4</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="app-layout">
        
        <aside class="sidebar">
            <div class="brand">
                <div class="logo">Osyris</div>
                <span>Employee Mgmt System</span>
            </div>
            
            <nav class="t-nav">
                <button class="tab-link active" onclick="openTab(event, 'tab-overview')" id="nav-1">
                    <span class="color-dot" style="background:var(--c-blue);"></span> Overview Analytics
                </button>
                <button class="tab-link" onclick="openTab(event, 'tab-projects')" id="nav-2">
                    <span class="color-dot" style="background:var(--c-gold);"></span> Active Projects
                </button>
                <button class="tab-link" onclick="openTab(event, 'tab-roster')" id="nav-3">
                    <span class="color-dot" style="background:var(--c-green);"></span> Staff Directory
                </button>
                <button class="tab-link" onclick="openTab(event, 'tab-onboard')" id="nav-4">
                    <span class="color-dot" style="background:var(--c-purple);"></span> Onboarding
                </button>
                <button class="tab-link" onclick="openTab(event, 'tab-reviews')" id="nav-5">
                    <span class="color-dot" style="background:var(--c-rose);"></span> Corp Reviews
                </button>
                <button class="tab-link" onclick="openTab(event, 'tab-clock')" id="nav-6">
                    <span class="color-dot" style="background:var(--c-teal);"></span> Time Clock
                </button>
                <button class="tab-link" onclick="openTab(event, 'tab-lookup')" id="nav-7">
                    <span class="color-dot" style="background:var(--c-slate);"></span> Employee Lookup
                </button>
            </nav>

            <div style="flex:1;"></div>
            
            <div style="padding: 20px;">
                <button onclick="toggleDarkMode()" class="btn btn-outline" style="width:100%; margin-bottom:10px;">Toggle Night Mode</button>
                <a href="${pageContext.request.contextPath}/export" class="btn btn-primary" style="display:block; text-align:center; text-decoration:none;">Download CSV Report</a>
            </div>
        </aside>

        <main class="content-area">
            
            <!-- TAB 1 -->
            <section id="tab-overview" class="tab-content active-tab" style="display: block;">
                <div class="card-container header-card theme-blue">
                    <h1>Executive Analytics</h1>
                    <p>Live macro-organizational metrics driven by Java and rendered via Chart.js.</p>
                </div>
                
                <div class="metrics-grid" style="margin-bottom: 25px;">
                    <div class="metric-card"><h3>Gross Revenue</h3><div class="metric-number highlight-gold">${totalRevenue}</div></div>
                    <div class="metric-card"><h3>Active Employees</h3><div class="metric-number highlight-blue">${activeCount}</div></div>
                    <div class="metric-card"><h3>Total Logged Weekly Hours</h3><div class="metric-number highlight-green">${totalHours}h</div></div>
                </div>

                <div class="card-container" style="display:flex; justify-content:center; align-items:center; flex-direction:column;">
                    <h2>Departmental Overview</h2>
                    <div style="max-width: 400px; width: 100%; margin-top:20px;">
                        <canvas id="deptChart"></canvas>
                    </div>
                </div>
            </section>

            <!-- TAB 2: PROJECTS KANBAN WITH INTERACTIVE BUTTONS -->
            <section id="tab-projects" class="tab-content" style="display: none;">
                <div class="header-card theme-gold" style="margin-bottom:20px;">
                    <h2>Active Projects Overview</h2>
                    <p class="subtitle">Categorized view of all internal engagements. Move projects dynamically!</p>
                </div>
                
                <div class="kanban-board">
                    <!-- Column: Planning -->
                    <div class="kanban-col">
                        <div class="k-header">Planning</div>
                        <c:forEach var="proj" items="${projects}">
                            <c:if test="${proj.status == 'Planning'}">
                                <div class="k-card">
                                    <div class="k-title">${proj.projectName}</div>
                                    <div class="k-manager">${proj.assignedManager}</div>
                                    <div class="k-budget">$${proj.revenueCollection}</div>
                                    <form action="action" method="POST" style="margin-top:10px;">
                                        <input type="hidden" name="actionType" value="updateProject">
                                        <input type="hidden" name="projectId" value="${proj.projectId}">
                                        <input type="hidden" name="status" value="Active">
                                        <button type="submit" class="btn btn-sm btn-teal" style="width:100%;">Push to Active ➡</button>
                                    </form>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- Column: Active -->
                    <div class="kanban-col">
                        <div class="k-header">Active</div>
                        <c:forEach var="proj" items="${projects}">
                            <c:if test="${proj.status == 'Active'}">
                                <div class="k-card" style="border-left: 4px solid var(--c-teal);">
                                    <div class="k-title">${proj.projectName}</div>
                                    <div class="k-manager">${proj.assignedManager}</div>
                                    <div class="k-budget">$${proj.revenueCollection}</div>
                                    <form action="action" method="POST" style="margin-top:10px;">
                                        <input type="hidden" name="actionType" value="updateProject">
                                        <input type="hidden" name="projectId" value="${proj.projectId}">
                                        <input type="hidden" name="status" value="Completed">
                                        <button type="submit" class="btn btn-sm btn-primary" style="width:100%;">Mark Completed ✓</button>
                                    </form>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>

                    <!-- Column: Completed -->
                    <div class="kanban-col">
                        <div class="k-header" style="background:var(--c-green); color:#fff;">Completed</div>
                        <c:forEach var="proj" items="${projects}">
                            <c:if test="${proj.status == 'Completed'}">
                                <div class="k-card" style="border-left: 4px solid var(--c-green); opacity: 0.8;">
                                    <div class="k-title" style="text-decoration: line-through;">${proj.projectName}</div>
                                    <div class="k-manager">${proj.assignedManager}</div>
                                    <div class="k-budget">$${proj.revenueCollection}</div>
                                    <span style="font-size:11px; color:var(--text-muted); display:block; margin-top:10px;">Archived.</span>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- TAB 3: ROSTER -->
            <section id="tab-roster" class="tab-content" style="display: none;">
                <div class="card-container theme-green">
                    <h2>Staff Directory</h2>
                    <p class="subtitle" style="font-size:12px;">Click a Header attribute (e.g. Employee or Weekly Hrs) to instantly sort!</p>
                    <div class="table-scroll">
                        <table id="rosterTable">
                            <thead>
                                <tr>
                                    <th onclick="sortTable(0)" style="cursor:pointer;" title="Sort Alphabetically">Employee ⇅</th>
                                    <th onclick="sortTable(1)" style="cursor:pointer;" title="Sort by Dept">Department ⇅</th>
                                    <th onclick="sortTable(2)" style="cursor:pointer;" title="Sort by Hrs">Weekly Hrs ⇅</th>
                                    <th onclick="sortTable(3)" style="cursor:pointer;" title="Sort by Avg">Daily Avg ⇅</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="emp" items="${employees}">
                                    <tr>
                                        <td data-sort="${emp.name}">
                                            <div class="emp-wrapper">
                                                <div class="emp-name">${emp.name} <span class="emp-id">#${emp.id}</span></div>
                                                <div class="emp-subtext">${emp.role}</div>
                                            </div>
                                        </td>
                                        <td data-sort="${emp.department}"><span class="badge dept-badge">${emp.department}</span></td>
                                        <td data-sort="${emp.weeklyHours}"><span class="hours-text">${emp.weeklyHours}h</span> <div class="emp-subtext">in ${emp.daysWorkedThisWeek} days</div></td>
                                        <td data-sort="${emp.dailyAverage}">
                                            <span class="avg-badge">
                                                <fmt:formatNumber value="${emp.dailyAverage}" pattern="#0.0"/>h
                                            </span>
                                        </td>
                                        <td>
                                            <div style="display:flex; gap:8px;">
                                                <button class="btn btn-primary btn-sm" onclick="openEditModal(${emp.id}, '${emp.name}', '${emp.email}', '${emp.role}', '${emp.department}', '${emp.joiningDate}', '${emp.endDate}')">Edit</button>
                                                <form action="action" method="POST" onsubmit="return confirmTerminate('${emp.name}')" style="display:inline;">
                                                    <input type="hidden" name="actionType" value="deleteEmployee">
                                                    <input type="hidden" name="id" value="${emp.id}">
                                                    <button type="submit" class="btn btn-danger btn-sm">Terminate</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <!-- TAB 4: ONBOARDING -->
            <section id="tab-onboard" class="tab-content" style="display: none;">
                <div class="card-container form-centric theme-purple">
                    <h2>Onboard New Hire</h2>
                    <form action="action" method="POST" class="standard-form">
                        <input type="hidden" name="actionType" value="addEmployee">
                        <div class="form-row"><div class="form-group"><label>Full Name</label><input type="text" name="name" required></div><div class="form-group"><label>Email</label><input type="email" name="email" required></div></div>
                        <div class="form-row">
                            <div class="form-group"><label>Role</label><input type="text" name="role" required></div>
                            <div class="form-group"><label>Department</label>
                            <select name="department" required>
                                <option value="">-- Select Department --</option>
                                <option value="Project Analysis">Project Analysis</option><option value="HR Overview">HR Overview</option>
                                <option value="Creative Design">Creative Design</option><option value="Corporate Operations">Corporate Operations</option>
                                <option value="Financial Review">Financial Review</option><option value="Client Support">Client Support</option>
                            </select></div>
                        </div>
                        <div class="form-row"><div class="form-group"><label>Joining Date</label><input type="date" name="joiningDate" required></div></div>
                        <button type="submit" class="btn btn-purple">Register to System</button>
                    </form>
                </div>
            </section>

            <!-- TAB 5: REVIEWS -->
            <section id="tab-reviews" class="tab-content" style="display: none;">
                <div class="reviews-layout">
                    <div class="card-container theme-rose">
                        <h2>Leave Corporate Review</h2>
                        <form action="action" method="POST" class="standard-form">
                            <input type="hidden" name="actionType" value="addReview">
                            <div class="form-group"><label>Name (Optional)</label><input type="text" name="name"></div>
                            <div class="form-group"><label>Rating (1-5)</label><input type="number" name="rating" min="1" max="5" value="5" required></div>
                            <div class="form-group"><label>Feedback</label><textarea name="feedback" rows="4" required></textarea></div>
                            <button type="submit" class="btn btn-rose" style="width:100%;">Submit Feedback</button>
                        </form>
                    </div>
                </div>
            </section>

            <!-- TAB 6: TIME CLOCK -->
            <section id="tab-clock" class="tab-content" style="display: none;">
                <div class="reviews-layout">
                    <div class="card-container form-centric theme-teal"><h2>Daily Time Clock</h2>
                        <form action="action" method="POST" class="standard-form">
                            <input type="hidden" name="actionType" value="logTime">
                            <div class="form-group" style="margin-bottom:15px;"><label>Employee</label>
                            <select name="employeeId" required style="padding:10px; border-radius:6px; background:var(--surface); color:var(--text-main); border:1px solid var(--border);">
                            <option value="">-- Choose Staff Member --</option>
                            <c:forEach var="emp" items="${employees}"><option value="${emp.id}">${emp.name}</option></c:forEach>
                            </select></div>
                            <div class="form-group" style="margin-bottom:20px;"><label>Today's Logged Hours</label><input type="number" name="todaysHours" value="8" required></div>
                            <button type="submit" class="btn btn-teal" style="width:100%;">Submit Time Punch</button>
                        </form>
                    </div>
                </div>
            </section>

            <!-- TAB 7: LOOKUP -->
            <section id="tab-lookup" class="tab-content" style="display: none;">
                <div class="card-container theme-slate" style="max-width:800px; margin:0 auto;">
                    <h2>Employee Lookup Console</h2>
                    <div class="search-bar" style="display:flex; gap:10px; margin-bottom: 30px;">
                        <input type="text" id="searchInput" placeholder="Search Alice, or ID..." style="flex:1; padding:12px; border-radius:6px; border:2px solid var(--border); background:var(--surface); color:var(--text-main);">
                        <button onclick="performSearch()" class="btn btn-primary">Retrieve Profile</button>
                    </div>
                    <div id="profile-container" style="display:none; animation: fadeIn 0.4s;">
                        <div class="profile-card">
                            <div class="p-header"><div class="p-avatar" id="p-avatar-char">A</div>
                            <div class="p-titles"><h1 id="p-name">Name</h1><p id="p-role" style="color:var(--c-blue); font-weight:600;">Role</p></div></div>
                            <div class="p-body">
                                <div class="p-item"><span>Sys ID:</span> <strong id="p-id">#</strong></div>
                                <div class="p-item"><span>Email:</span> <strong id="p-email">e@mail</strong></div>
                                <div class="p-item"><span>Department:</span> <strong id="p-dept">Dept</strong></div>
                                <div class="p-item"><span>Currently:</span> <strong id="p-status">Active</strong></div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>
    </div>

    <!-- Edit Profile Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content card-container">
            <div class="modal-header"><h2>Modify Profile</h2><span class="close-btn" onclick="closeEditModal()">&times;</span></div>
            <form action="action" method="POST" class="standard-form">
                <input type="hidden" name="actionType" value="editEmployee">
                <input type="hidden" name="id" id="edit-id">
                <div class="form-row"><div class="form-group"><label>Name</label><input type="text" name="name" id="edit-name" required></div><div class="form-group"><label>Email</label><input type="text" name="email" id="edit-email" required></div></div>
                <div class="form-row"><div class="form-group"><label>Role</label><input type="text" name="role" id="edit-role" required></div>
                <div class="form-group"><label>Deprt</label><select name="department" id="edit-dept" required><option value="Project Analysis">Project Analysis</option><option value="HR Overview">HR Overview</option><option value="Creative Design">Creative Design</option><option value="Corporate Operations">Corporate Operations</option><option value="Financial Review">Financial Review</option><option value="Client Support">Client Support</option></select></div></div>
                <div class="form-row"><div class="form-group"><label>Join Date</label><input type="text" name="joiningDate" id="edit-join" required></div><div class="form-group"><label>End Date</label><input type="text" name="endDate" id="edit-end" required></div></div>
                <div class="form-actions" style="margin-top: 20px;"><button type="submit" class="btn btn-primary" style="width:100%;">Commit Edit</button></div>
            </form></div></div>

    <script>
        const searchDB = { <c:forEach var="emp" items="${employees}"> "${emp.id}": { id: "${emp.id}", name: "${emp.name}", email: "${emp.email}", role: "${emp.role}", dept: "${emp.department}", join: "${emp.joiningDate}", end: "${emp.endDate}" }, </c:forEach> };
        function confirmTerminate(name) { return confirm("WARNING! Scrub " + name + " permanently?"); }
        function toggleDarkMode() {
            const current = document.documentElement.getAttribute('data-theme');
            document.documentElement.setAttribute('data-theme', current === 'light' ? 'dark' : 'light');
        }
        
        // Sorting Logic dynamically switching ASC/DESC
        let sortDirections = [true, true, true, true]; // flags for columns 0, 1, 2, 3
        function sortTable(n) {
            var table = document.getElementById("rosterTable");
            var rows = Array.from(table.rows).slice(1);
            var isAsc = sortDirections[n];
            
            rows.sort(function(a, b) {
                var x = a.cells[n].getAttribute("data-sort");
                var y = b.cells[n].getAttribute("data-sort");
                
                // If it's pure numbers (column 2 for hrs or 3 for avg) parse it, else compare string
                if (n === 2 || n === 3) {
                    return isAsc ? (parseFloat(x) - parseFloat(y)) : (parseFloat(y) - parseFloat(x));
                } else {
                    return isAsc ? x.localeCompare(y) : y.localeCompare(x);
                }
            });
            sortDirections[n] = !isAsc; // toggle
            rows.forEach(function(row) { table.tBodies[0].appendChild(row); });
        }

        window.onload = function() {
            let d = {}; for(let k in searchDB) d[searchDB[k].dept] = (d[searchDB[k].dept] || 0) + 1;
            new Chart(document.getElementById('deptChart').getContext('2d'), {
                type: 'doughnut', data: { labels: Object.keys(d), datasets: [{ data: Object.values(d), backgroundColor: ['#2563eb', '#10b981', '#f59e0b', '#8b5cf6', '#f43f5e', '#14b8a6'] }] },
                options: { cutout: '70%'}
            });
            var t = new URLSearchParams(window.location.search).get('tab');
            if(t) document.getElementById({"1":"nav-1", "2":"nav-2", "3":"nav-3", "4":"nav-4", "5":"nav-5", "6":"nav-6", "7":"nav-7"}[t]).click();
        };

        function openTab(evt, tid) {
            Array.from(document.getElementsByClassName("tab-content")).forEach(e => { e.style.display="none"; e.classList.remove("active-tab"); });
            Array.from(document.getElementsByClassName("tab-link")).forEach(e => e.classList.remove("active"));
            document.getElementById(tid).style.display = "block";
            setTimeout(() => document.getElementById(tid).classList.add("active-tab"), 10);
            evt.currentTarget.classList.add("active");
        }
        function performSearch() {
            const q = document.getElementById('searchInput').value.trim().toLowerCase();
            let f = searchDB[q] || Object.values(searchDB).find(x => x.name.toLowerCase().includes(q));
            if(f) {
                document.getElementById('p-avatar-char').innerText = f.name.charAt(0);
                document.getElementById('p-name').innerText = f.name; document.getElementById('p-role').innerText = f.role;
                document.getElementById('p-id').innerText = f.id; document.getElementById('p-email').innerText = f.email;
                document.getElementById('p-dept').innerText = f.dept; document.getElementById('p-status').innerText = f.end === "Active" ? "Active" : "Terminated";
                document.getElementById('profile-container').style.display = "block";
            } else { document.getElementById('profile-container').style.display = "none"; Swal.fire('No match','','warning'); }
        }
        function openEditModal(i, n, e, r, d, j, end) {
            document.getElementById('edit-id').value = i; document.getElementById('edit-name').value = n; document.getElementById('edit-email').value = e;
            document.getElementById('edit-role').value = r; document.getElementById('edit-dept').value = d; document.getElementById('edit-join').value = j; document.getElementById('edit-end').value = end;
            document.getElementById('editModal').style.display = "flex"; setTimeout(() => document.getElementById('editModal').style.opacity = 1, 10);
        }
        function closeEditModal() { document.getElementById('editModal').style.opacity = 0; setTimeout(() => document.getElementById('editModal').style.display = "none", 300); }
    </script>
</body>
</html>
