# 🔐 PrivacyCheck – Personal Data Sharing Audit System

PrivacyCheck is a web-based application developed to help users organize and review personal data-sharing information associated with different online services. It provides a centralized dashboard for viewing registered services, shared-data records, privacy risk levels, and review reminders.

## 🎯 Objectives

- Organize information associated with different online services.
- View shared-data records in one place.
- Monitor service-wise privacy risk levels.
- Track upcoming and overdue review reminders.
- Provide convenient sign-in using Google authentication.
- Demonstrate Java web development and database integration.

## ✨ Features

- **User Authentication:** Login and Google sign-in integration.
- **Dashboard:** Overview of registered services and privacy indicators.
- **My Services:** View service names, categories, risk levels, and review dates.
- **Shared Data:** Review information associated with online services.
- **Review Reminders:** View upcoming and overdue review dates.
- **Database Integration:** Store and retrieve application records using Oracle Database XE.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java 21 | Backend programming |
| Java Servlets | Request handling and application logic |
| JSP | Dynamic web pages |
| HTML and CSS | User interface and styling |
| JDBC | Database connectivity |
| Oracle Database XE 21c | Data storage |
| Apache Tomcat 11 | Application server |
| Apache Maven | Dependency and build management |
| NetBeans IDE 30 | Development environment |
| Google OAuth 2.0 | Google sign-in integration |

## 🏗️ System Architecture

The application follows a web-based architecture:

1. **User Interface:** Users interact with JSP pages styled using HTML and CSS.
2. **Application Layer:** Java Servlets process requests and manage application logic.
3. **Database Access Layer:** JDBC executes SQL queries and retrieves records.
4. **Database Layer:** Oracle Database XE stores user, service, and shared-data information.
5. **Authentication:** Google OAuth 2.0 supports Google sign-in.

## 🗄️ Database Design

The project uses the following main tables:

- `APP_USER` – Stores user information and authentication-related fields.
- `ONLINE_SERVICE` – Stores online-service details, categories, risk levels, and review dates.
- `SHARED_DATA` – Stores shared-data notes and the date sharing began.

It also includes database views such as `VW_SERVICE_INVENTORY` and `VW_DASHBOARD_STATS` for service information and dashboard statistics.

## ⚙️ Prerequisites

Before running the project, install:

- JDK 21
- Apache NetBeans IDE
- Apache Tomcat 11
- Oracle Database XE 21c
- Maven
- Google OAuth credentials for Google sign-in

## 🚀 Setup and Installation

1. Clone or download this repository.
2. Open the project in NetBeans IDE.
3. Configure Oracle Database XE and create the `PRIVACYCHECK` schema.
4. Execute the database setup SQL script using the appropriate database user.
5. Configure database credentials securely through environment variables.
6. Configure Google OAuth credentials and the callback URL for your local environment.
7. Build the project using Maven.
8. Deploy the WAR application to Apache Tomcat.
9. Open the application in your browser using the configured local URL.

## 🔒 Security Notes

- Never commit database passwords, OAuth client secrets, access tokens, or other private credentials.
- Store secrets in environment variables or another secure configuration mechanism.
- Configure Google OAuth redirect URLs correctly for your environment.
- Use secure password hashing for local account authentication.

## 🎓 Project Information

**Project Name:** PrivacyCheck – Personal Data Sharing Audit System  
**Student:** Shivansh Chaurasiya  
**UID:** 26MCD10052  
**Program:** Master of Computer Applications (MCA) – Data Science  
**University:** Chandigarh University  
**Academic Session:** 2026–27  
**Project Type:** Academic Innovation Project (AIP)

## 🔮 Future Scope

- Add, edit, and delete shared-data records.
- Implement privacy activity logs.
- Add data-sharing reduction and revocation workflows.
- Generate downloadable privacy reports.
- Introduce advanced privacy risk insights and notifications.

## 📄 License

This project is developed for academic and educational purposes. Add a suitable open-source license if you intend to distribute it for reuse.

---

**PrivacyCheck — Making personal data-sharing information easier to review.**
