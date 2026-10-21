<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Review Reminders | PrivacyCheck</title>

    <style>
        /* ==============================
           GLOBAL STYLES
        ============================== */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --primary: #6d4aff;
            --primary-dark: #5135d9;
            --primary-light: #f0edff;
            --background: #f7f8fc;
            --surface: #ffffff;
            --text: #20243a;
            --muted: #7b8197;
            --border: #e9eaf2;
            --red: #e5484d;
            --orange: #d97706;
            --green: #15966a;
            --shadow: 0 8px 30px rgba(35, 32, 75, 0.055);
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Arial, sans-serif;
            background: var(--background);
            color: var(--text);
            line-height: 1.6;
        }

        a {
            text-decoration: none;
        }

        /* ==============================
           TOP HEADER
        ============================== */
        header {
            position: relative;
            overflow: hidden;
            padding: 30px 6%;
            color: #ffffff;
            background: linear-gradient(
                120deg,
                #21154e 0%,
                #4e35b5 52%,
                #7958ff 100%
            );
        }

        header::after {
            content: "";
            position: absolute;
            width: 250px;
            height: 250px;
            right: 8%;
            top: -150px;
            border: 1px solid rgba(255,255,255,0.16);
            border-radius: 50%;
            box-shadow:
                0 0 0 35px rgba(255,255,255,0.04),
                0 0 0 70px rgba(255,255,255,0.03);
            pointer-events: none;
        }

        .header-content {
            position: relative;
            z-index: 1;
            max-width: 1250px;
            margin: 0 auto;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 13px;
        }

        .brand-icon {
            display: grid;
            place-items: center;
            width: 45px;
            height: 45px;
            border-radius: 14px;
            background: rgba(255,255,255,0.16);
            border: 1px solid rgba(255,255,255,0.2);
            font-size: 23px;
            font-weight: 800;
        }

        .brand h1 {
            font-size: 25px;
            font-weight: 750;
            letter-spacing: -0.6px;
        }

        .brand p {
            margin-top: 1px;
            color: #ded7ff;
            font-size: 13px;
        }

        /* ==============================
           NAVIGATION
        ============================== */
        nav {
            position: sticky;
            top: 0;
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            gap: 8px;
            padding: 13px 5%;
            background: rgba(255,255,255,0.96);
            border-bottom: 1px solid var(--border);
            box-shadow: 0 4px 15px rgba(25, 24, 60, 0.025);
            backdrop-filter: blur(12px);
        }

        nav a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            border-radius: 10px;
            color: #626981;
            font-size: 13px;
            font-weight: 650;
            transition: all 0.2s ease;
        }

        nav a:hover {
            color: var(--primary);
            background: var(--primary-light);
        }

        nav a.active {
            color: var(--primary);
            background: var(--primary-light);
        }

        /* ==============================
           MAIN CONTENT
        ============================== */
        main {
            width: min(1200px, 100%);
            margin: 0 auto;
            padding: 36px 25px 55px;
        }

        .page-heading {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 18px;
            margin-bottom: 25px;
        }

        .eyebrow {
            margin-bottom: 7px;
            color: var(--primary);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.6px;
            text-transform: uppercase;
        }

        .page-heading h2 {
            color: #252641;
            font-size: clamp(25px, 4vw, 34px);
            line-height: 1.25;
            font-weight: 750;
            letter-spacing: -1px;
        }

        .muted {
            max-width: 650px;
            margin-top: 9px;
            color: var(--muted);
            font-size: 14px;
        }

        .page-tag {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 9px 14px;
            border: 1px solid #e4defe;
            border-radius: 30px;
            background: #f0edff;
            color: #6346df;
            font-size: 12px;
            font-weight: 700;
        }

        .page-tag span {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #7b61ff;
        }

        /* ==============================
           STATISTIC CARDS
        ============================== */
        .cards {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
            margin: 28px 0 32px;
        }

        .card {
            position: relative;
            overflow: hidden;
            min-height: 175px;
            padding: 23px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 19px;
            box-shadow: var(--shadow);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 35px rgba(35, 32, 75, 0.09);
        }

        .card::after {
            content: "";
            position: absolute;
            width: 100px;
            height: 100px;
            right: -35px;
            bottom: -48px;
            border-radius: 50%;
            background: var(--card-tint);
            opacity: 0.65;
        }

        .card.total {
            --card-tint: #e9e4ff;
            --card-color: #6d4aff;
        }

        .card.overdue-card {
            --card-tint: #ffe2e4;
            --card-color: #e5484d;
        }

        .card.upcoming-card {
            --card-tint: #ffedcf;
            --card-color: #d97706;
        }

        .card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .card-label {
            color: #6f748b;
            font-size: 13px;
            font-weight: 650;
        }

        .stat-icon {
            display: grid;
            place-items: center;
            width: 44px;
            height: 44px;
            border-radius: 14px;
            background: var(--card-tint);
            color: var(--card-color);
            font-size: 21px;
            font-weight: 800;
        }

        .number {
            display: block;
            margin-top: 17px;
            color: #252641;
            font-size: 35px;
            line-height: 1.1;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .number.overdue {
            color: var(--red);
        }

        .number.upcoming {
            color: var(--orange);
        }

        .card-note {
            display: block;
            margin-top: 9px;
            color: #9297a9;
            font-size: 11px;
        }

        /* ==============================
           TABLE SECTION
        ============================== */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            margin: 0 0 17px;
        }

        .section-header h3 {
            color: #282943;
            font-size: 18px;
            font-weight: 750;
        }

        .section-header p {
            margin-top: 3px;
            color: var(--muted);
            font-size: 12px;
        }

        .table-card {
            overflow: hidden;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
        }

        .table-scroll {
            overflow-x: auto;
            width: 100%;
        }

        table {
            width: 100%;
            min-width: 780px;
            border-collapse: separate;
            border-spacing: 0;
        }

        thead th {
            padding: 17px 19px;
            background: #faf9ff;
            color: #777c92;
            border-bottom: 1px solid var(--border);
            text-align: left;
            white-space: nowrap;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        tbody td {
            padding: 18px 19px;
            color: #535970;
            border-bottom: 1px solid #f0f0f6;
            font-size: 13px;
            vertical-align: middle;
        }

        tbody tr {
            transition: background 0.2s ease;
        }

        tbody tr:hover {
            background: #fbfaff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody td:first-child {
            color: #888da1;
            font-size: 12px;
            font-weight: 700;
        }

        tbody td:nth-child(2) {
            color: #292b45;
            font-weight: 700;
        }

        /* ==============================
           STATUS BADGES
        ============================== */
        .status {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 7px 11px;
            border-radius: 30px;
            white-space: nowrap;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.4px;
        }

        .status::before {
            content: "";
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
        }

        .status-overdue {
            background: #fff0f0;
            color: #cf343b;
            border: 1px solid #ffdddd;
        }

        .status-upcoming {
            background: #fff7e8;
            color: #b66a08;
            border: 1px solid #ffebc6;
        }

        .risk-badge {
            display: inline-block;
            padding: 5px 9px;
            border-radius: 7px;
            background: #f1efff;
            color: #6949df;
            font-size: 11px;
            font-weight: 700;
        }

        /* ==============================
           EMPTY STATE
        ============================== */
        .empty {
            padding: 55px 20px !important;
            color: #858ba0 !important;
            text-align: center;
            font-size: 14px !important;
        }

        .empty::before {
            content: "✓";
            display: grid;
            place-items: center;
            width: 48px;
            height: 48px;
            margin: 0 auto 13px;
            border-radius: 50%;
            background: #e6f8ef;
            color: #15966a;
            font-size: 23px;
            font-weight: 800;
        }

        /* ==============================
           FOOTER
        ============================== */
        footer {
            padding: 24px 20px;
            border-top: 1px solid var(--border);
            background: #ffffff;
            color: #9297a9;
            text-align: center;
            font-size: 12px;
        }

        footer strong {
            color: #6d4aff;
            font-weight: 750;
        }

        /* ==============================
           RESPONSIVE DESIGN
        ============================== */
        @media (max-width: 850px) {
            .cards {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .card:last-child {
                grid-column: 1 / -1;
            }

            nav {
                justify-content: flex-start;
                padding-left: 20px;
                padding-right: 20px;
            }

            nav a {
                padding: 9px 12px;
            }
        }

        @media (max-width: 560px) {
            header {
                padding: 23px 20px;
            }

            .brand h1 {
                font-size: 22px;
            }

            nav {
                gap: 4px;
                padding: 10px 12px;
            }

            nav a {
                padding: 9px 10px;
                font-size: 11px;
            }

            main {
                padding: 27px 15px 40px;
            }

            .page-heading {
                align-items: flex-start;
            }

            .page-heading h2 {
                font-size: 27px;
            }

            .cards {
                grid-template-columns: 1fr;
                gap: 13px;
                margin-top: 22px;
            }

            .card,
            .card:last-child {
                grid-column: auto;
                min-height: 150px;
                padding: 20px;
            }

            .number {
                font-size: 31px;
            }

            .table-card {
                border-radius: 13px;
            }

            .section-header h3 {
                font-size: 16px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                scroll-behavior: auto !important;
                transition: none !important;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="header-content">
        <div class="brand">
            <div class="brand-icon">P</div>
            <div>
                <h1>PrivacyCheck</h1>
                <p>Personal Data Sharing Audit</p>
            </div>
        </div>
    </div>
</header>

<nav aria-label="Main navigation">
    <a href="${pageContext.request.contextPath}/dashboard">
        ◫ Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/services">
        ▤ My Services
    </a>
    <a href="${pageContext.request.contextPath}/shared-data">
        ◈ Shared Data
    </a>
    <a class="active"
       href="${pageContext.request.contextPath}/reminders"
       aria-current="page">
        ◷ Review Reminders
    </a>
</nav>

<main>
    <div class="page-heading">
        <div>
            <div class="eyebrow">Privacy monitoring</div>
            <h2>Review Reminders</h2>
            <p class="muted">
                Keep track of overdue privacy reviews and upcoming reviews
                due within the next seven days.
            </p>
        </div>

        <div class="page-tag">
            <span></span>
            Review overview
        </div>
    </div>

    <div class="cards">
        <div class="card total">
            <div class="card-top">
                <span class="card-label">Total Reviews</span>
                <div class="stat-icon">▤</div>
            </div>
            <span class="number">
                <c:out value="${reminderCount}"/>
            </span>
            <span class="card-note">Reviews requiring attention</span>
        </div>

        <div class="card overdue-card">
            <div class="card-top">
                <span class="card-label">Overdue Reviews</span>
                <div class="stat-icon">!</div>
            </div>
            <span class="number overdue">
                <c:out value="${overdueCount}"/>
            </span>
            <span class="card-note">Past their scheduled review date</span>
        </div>

        <div class="card upcoming-card">
            <div class="card-top">
                <span class="card-label">Upcoming Reviews</span>
                <div class="stat-icon">◷</div>
            </div>
            <span class="number upcoming">
                <c:out value="${upcomingCount}"/>
            </span>
            <span class="card-note">Due within the next seven days</span>
        </div>
    </div>

    <div class="section-header">
        <div>
            <h3>Review Schedule</h3>
            <p>Services with overdue or upcoming privacy reviews</p>
        </div>
    </div>

    <div class="table-card">
        <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>Service ID</th>
                        <th>Service Name</th>
                        <th>Category</th>
                        <th>Risk Level</th>
                        <th>Review Date</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${not empty reminders}">
                            <c:forEach var="r" items="${reminders}">
                                <tr>
                                    <td>
                                        <c:out value="${r.id}"/>
                                    </td>
                                    <td>
                                        <c:out value="${r.serviceName}"/>
                                    </td>
                                    <td>
                                        <c:out value="${r.category}"/>
                                    </td>
                                    <td>
                                        <span class="risk-badge">
                                            <c:out value="${r.risk}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <c:out value="${r.reviewDate}"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status == 'OVERDUE'}">
                                                <span class="status status-overdue">
                                                    OVERDUE
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status status-upcoming">
                                                    UPCOMING
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="6" class="empty">
                                    No overdue or upcoming reviews found.
                                    Your review schedule is clear.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</main>

<footer>
    <strong>PrivacyCheck</strong> &nbsp;|&nbsp; AIP Project
    <br>
    Personal data awareness and privacy review management
</footer>

</body>
</html>
