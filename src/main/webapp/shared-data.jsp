<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shared Data | PrivacyCheck</title>

    <style>
        /* =========================
           GLOBAL STYLES
        ========================= */
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
            --text: #252641;
            --muted: #7b8197;
            --border: #e9eaf2;
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

        /* =========================
           HEADER
        ========================= */
        header {
            position: relative;
            overflow: hidden;
            padding: 28px 6%;
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
            width: 230px;
            height: 230px;
            top: -145px;
            right: 8%;
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
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 14px;
            background: rgba(255,255,255,0.16);
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

        /* =========================
           NAVIGATION
        ========================= */
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
            box-shadow: 0 4px 15px rgba(25,24,60,0.025);
            backdrop-filter: blur(12px);
        }

        nav a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 15px;
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

        nav a:focus-visible {
            outline: 3px solid #b8aaff;
            outline-offset: 3px;
        }

        /* =========================
           MAIN CONTENT
        ========================= */
        main {
            width: min(1200px, 100%);
            margin: 0 auto;
            padding: 36px 25px 55px;
        }

        .intro {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 18px;
            margin-bottom: 27px;
        }

        .eyebrow {
            margin-bottom: 7px;
            color: var(--primary);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1.6px;
            text-transform: uppercase;
        }

        .intro h2 {
            color: var(--text);
            font-size: clamp(26px, 4vw, 34px);
            line-height: 1.25;
            font-weight: 750;
            letter-spacing: -1px;
        }

        .intro p {
            max-width: 680px;
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
            background: var(--primary-light);
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

        /* =========================
           SUMMARY CARD
        ========================= */
        .summary {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            overflow: hidden;
            margin: 26px 0 34px;
            padding: 26px 29px;
            border: 1px solid #e4defe;
            border-radius: 19px;
            background: linear-gradient(
                110deg,
                #ffffff 0%,
                #f5f2ff 100%
            );
            box-shadow: var(--shadow);
            transition: box-shadow 0.25s ease,
                        transform 0.25s ease;
        }

        .summary:hover {
            transform: translateY(-3px);
            box-shadow: 0 14px 35px rgba(35,32,75,0.08);
        }

        .summary::after {
            content: "";
            position: absolute;
            width: 155px;
            height: 155px;
            right: 70px;
            top: -100px;
            border-radius: 50%;
            background: #e8e1ff;
            opacity: 0.65;
        }

        .summary-content {
            position: relative;
            z-index: 1;
        }

        .summary-label {
            color: #72768d;
            font-size: 13px;
            font-weight: 650;
        }

        .summary strong {
            display: block;
            margin-top: 7px;
            color: var(--primary);
            font-size: 40px;
            line-height: 1.2;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .summary-note {
            display: block;
            margin-top: 7px;
            color: #8b8fa3;
            font-size: 12px;
        }

        .summary-icon {
            position: relative;
            z-index: 1;
            display: grid;
            place-items: center;
            width: 60px;
            height: 60px;
            flex-shrink: 0;
            border: 1px solid #e3dbff;
            border-radius: 18px;
            background: #ece7ff;
            color: var(--primary);
            font-size: 27px;
            font-weight: 800;
        }

        /* =========================
           TABLE SECTION
        ========================= */
        .section-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 17px;
        }

        .section-heading h3 {
            color: var(--text);
            font-size: 18px;
            font-weight: 750;
        }

        .section-heading p {
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
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 800px;
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
            text-align: left;
            vertical-align: middle;
            font-size: 13px;
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

        /* =========================
           DATA CATEGORY BADGE
        ========================= */
        .category {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            max-width: 240px;
            padding: 7px 11px;
            border: 1px solid #e3ddff;
            border-radius: 30px;
            background: #f1eeff;
            color: #6545d9;
            font-size: 11px;
            font-weight: 700;
            overflow-wrap: anywhere;
        }

        .category::before {
            content: "";
            width: 6px;
            height: 6px;
            flex-shrink: 0;
            border-radius: 50%;
            background: #846bff;
        }

        /* =========================
           NOTES CELL
        ========================= */
        .notes {
            max-width: 300px;
            color: #737990;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        /* =========================
           EMPTY STATE
        ========================= */
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
            width: 52px;
            height: 52px;
            margin: 0 auto 13px;
            border-radius: 17px;
            background: #e6f8ef;
            color: #15966a;
            font-size: 24px;
            font-weight: 800;
        }

        /* =========================
           FOOTER
        ========================= */
        footer {
            padding: 24px 20px;
            border-top: 1px solid var(--border);
            background: #ffffff;
            color: #9297a9;
            text-align: center;
            font-size: 12px;
        }

        footer strong {
            color: var(--primary);
            font-weight: 750;
        }

        /* =========================
           RESPONSIVE DESIGN
        ========================= */
        @media (max-width: 700px) {
            header {
                padding: 23px 20px;
            }

            nav {
                justify-content: flex-start;
                gap: 4px;
                padding: 10px 12px;
            }

            nav a {
                padding: 9px 10px;
                font-size: 11px;
            }

            main {
                padding: 28px 16px 40px;
            }

            .intro {
                align-items: flex-start;
            }

            .intro h2 {
                font-size: 28px;
            }

            .summary {
                padding: 22px;
            }

            .summary strong {
                font-size: 35px;
            }

            .summary-icon {
                width: 51px;
                height: 51px;
                border-radius: 15px;
                font-size: 23px;
            }

            .table-card {
                border-radius: 13px;
            }
        }

        @media (max-width: 380px) {
            .brand h1 {
                font-size: 22px;
            }

            .intro h2 {
                font-size: 25px;
            }

            .summary {
                padding: 18px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
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
                <p>Personal Data Sharing Audit System</p>
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
    <a class="active"
       href="${pageContext.request.contextPath}/shared-data"
       aria-current="page">
        ◈ Shared Data
    </a>
    <a href="${pageContext.request.contextPath}/reminders">
        ◷ Review Reminders
    </a>
</nav>

<main>
    <section class="intro">
        <div>
            <div class="eyebrow">Personal data overview</div>
            <h2>Shared Data Inventory</h2>
            <p>
                Review the personal-data categories associated with your
                registered online services and understand what information
                is recorded in your inventory.
            </p>
        </div>

        <div class="page-tag">
            <span></span>
            Data inventory
        </div>
    </section>

    <section class="summary">
        <div class="summary-content">
            <p class="summary-label">Total Shared-Data Records</p>
            <strong>
                <c:out value="${recordCount}"/>
            </strong>
            <span class="summary-note">
                Records associated with your registered online services
            </span>
        </div>

        <div class="summary-icon">◈</div>
    </section>

    <section class="section-heading">
        <div>
            <h3>Shared Data Records</h3>
            <p>Personal-data categories, service details, and notes</p>
        </div>
    </section>

    <section class="table-card">
        <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>Record ID</th>
                        <th>Online Service</th>
                        <th>Data Category</th>
                        <th>Notes</th>
                        <th>Shared Since</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${not empty sharedDataRecords}">
                            <c:forEach var="s" items="${sharedDataRecords}">
                                <tr>
                                    <td>
                                        <c:out value="${s.id}"/>
                                    </td>
                                    <td>
                                        <c:out value="${s.serviceName}"/>
                                    </td>
                                    <td>
                                        <span class="category">
                                            <c:out value="${s.category}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="notes">
                                            <c:out value="${s.notes}"/>
                                        </div>
                                    </td>
                                    <td>
                                        <c:out value="${s.sharedSince}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="empty">
                                    No shared-data records were found
                                    for this user.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </section>
</main>

<footer>
    <strong>PrivacyCheck</strong> &nbsp;|&nbsp; AIP Project
    <br>
    Personal Data Sharing Audit &copy; 2026
</footer>

</body>
</html>