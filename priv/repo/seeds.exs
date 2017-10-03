alias Contento.Settings
alias Contento.Accounts
alias Contento.Content

now = fn -> DateTime.utc_now() end

Settings.create_settings(%{
  "website_title" => "Your Contento Website",
  "website_description" => "A lovely website made with passion and Contento!"
})

Accounts.create_user(%{
  "name" => "Super User",
  "email" => "su@example.org",
  "handle" => "su",
  "website" => "https://google.com",
  "bio" => "I'm nobody...",
  "location" => "Processor",
  "password" => "12345678"
})

Content.create_page(%{
  "slug" => "about",

  "title" => "About",
  "content" => "Tell people something nice about you!",

  "published" => true,
  "published_at" => now.(),

  "author_id" => 1
})

Content.create_post(%{
  "slug" => "getting-started",

  "title" => "Getting started with Contento",
  "content" => "Hello!! This is your first post on Contento!",

  "published" => true,
  "published_at" => now.(),

  "author_id" => 1
})
