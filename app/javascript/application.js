import Rails from "@rails/ujs"

Rails.start()

console.log("chat-app application entry point initialized")
import "./controllers"
import "@hotwired/turbo-rails"
