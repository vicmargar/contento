# Roadmap

### 0.0.1

- [x] Authentication
- [x] Basic admin layout and theme to get going (eventually should be refactored in future).
- [x] Multiple themes.
- [x] Create posts, pages and users.
- [x] Manage account (current user's details and preferences).
- [x] Manage the website settings.
  - [x] Website title and description.
  - [x] Maintenance mode and message.
- [x] When a user is created, send him an email with an activation link.
- [x] When user activates his account, he must setup a password on first login.
- [ ] Create proper documentation and user guides.
- [x] Pagination.
- [x] Markdown support.
- [ ] Simplo Theme (the default Contento theme):
  - [x] Index page (lists all posts)
  - [x] Single post page (shows a single post)
  - [x] Single page page (shows a single page)
  - [ ] Author page (shows a user's information and lists authored posts)
  - [ ] Maintenance page
- [ ] Docker for production (should compile assets and source and run the server).

### 0.0.2

- [ ] Archives (allow a visitor to browse a chronologically organized posts list)
  - [ ] Simplo Theme: Archives page
- [ ] Search (allow a visitor to search for posts, pages and authors)

### 0.0.3

- [ ] Tests, tests and more tests

### Future

- [ ] Comments (service or self-hosted)
- [ ] Media management (upload and manage media files)
  - Decide whether to use a service like AWS S3 (preferable, but may be a constraint to some users) to store files or use local storage.
- [ ] Analytics built-in integration (probably using GA)
- [ ] Dashboard improvements (better statistics, quick actions, etc...)
- [ ] Plugins system to extend default functionalities
- [ ] User Roles
- [ ] Backup data and source code
