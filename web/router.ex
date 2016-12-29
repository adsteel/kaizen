defmodule Kaizen.Router do
  use Kaizen.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated_browser do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated, handler: Kaizen.AuthErrorHandler
    plug Kaizen.Plug.Auth, repo: Kaizen.Repo
  end

  pipeline :api do
    plug :accepts, ["html"]
  end

  scope "/", Kaizen do
    pipe_through :browser

    resources "/registrations", RegistrationController, only: [:new, :create]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/", Kaizen do
    pipe_through :browser
    pipe_through :authenticated_browser

    get "/", ProjectController, :index
    resources "/users", UserController
    resources "/projects", ProjectController do
      resources "/user_projects", UserProjectController, only: [:create, :index]
      resources "/stories", Project.StoryController, only: [:create, :delete]
    end
    resources "/user_projects", UserProjectController, only: [:delete]
  end

  scope "/api", Kaizen do
    pipe_through :api

    resources "/projects", ProjectController, only: [] do
      resources "/stories", Project.StoryController, only: [:index]
    end
  end
end
