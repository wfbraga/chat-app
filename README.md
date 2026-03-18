# Chat App (Hotwire Study Project)

This is a study project developed to learn **Hotwire** (Turbo and Stimulus) by creating a real-time chat application. In this app, clients can start conversations, and administrators or staff members (Support, Sales) can be assigned to handle them.

## 🚀 Overview

- **Real-time Communication**: Uses ActionCable and Turbo Streams for instant message broadcasting.
- **Role-based Access**: Supports `user`, `admin`, `support`, and `sales` roles.
- **Conversation Management**: Admin/Staff can assign conversations to themselves or others.
- **Attachments**: Supports file attachments in messages using Active Storage.

## 🛠 Requirements

- **Ruby**: 3.0.1
- **Rails**: 6.1.3
- **Database**: PostgreSQL
- **JS Runtime/Bundler**: [Bun](https://bun.sh/)
- **CSS Processor**: Sass (via Yarn)
- **Package Managers**: Bundler (Ruby), Yarn (JS)

## ⚙️ Setup & Run

### 1. Initial Setup
The project includes a setup script for convenience:
```bash
bin/setup
```
Alternatively, you can run the steps manually:
```bash
bundle install
yarn install
rails db:prepare
```

### 2. Environment Variables
The project uses `dotenv-rails`. Create a `.env` file in the root if you need to override default configurations:
- `DATABASE_URL` (optional)
- `REDIS_URL` (for ActionCable in production)

### 3. Development Server
Run the application along with JS and CSS watchers using:
```bash
bin/dev
```
This uses Foreman to manage:
- Rails server (`bin/rails server`)
- JS build (`bun run build --watch`)
- CSS build (`yarn watch:css --watch`)

## 📜 Scripts

Available via `package.json`:
- `yarn build:css`: Compiles Sass for both app and admin interfaces.
- `yarn build`: Bundles JavaScript using Bun and `bun.config.js`.
- `yarn watch:css`: Runs Sass in watch mode.

## 🧪 Testing

The project uses `Minitest` (standard Rails testing suite).

- **Run all tests**:
  ```bash
  rails test
  ```
- **Run a specific test**:
  ```bash
  rails test test/models/message_test.rb
  ```

## 📂 Project Structure

- `app/models/`: Core logic for `User`, `Conversation`, and `Message`.
- `app/controllers/admin/`: Controllers for staff-side conversation management.
- `app/javascript/controllers/`: Stimulus controllers for frontend interactivity.
- `app/views/`:
    - `messages/`: User-side message partials and views.
    - `admin/messages/`: Staff-side message partials.
- `bin/dev`: Entry point for development.
- `bun.config.js`: Configuration for Bun bundler.

## 📝 TODOs & Future Improvements

- [ ] Implement full test coverage for all roles.
- [ ] Add production deployment instructions (Capistrano is partially configured).
- [ ] Document specific environment variable requirements for OAuth (Facebook/Google).

## 📄 License

This project is intended for study purposes. [TODO: Add specific license, e.g., MIT]
