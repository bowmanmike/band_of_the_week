defmodule BandOfTheWeekWeb.Router do
  use BandOfTheWeekWeb, :router

  import BandOfTheWeekWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BandOfTheWeekWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admins_only do
    plug :admin_basic_auth
  end

  scope "/", BandOfTheWeekWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/bands", BandOfTheWeekWeb do
    pipe_through [:browser, :require_authenticated_user]

    live "/", BandLive.Index, :index
    live "/new", BandLive.Index, :new
    live "/:id/edit", BandLive.Index, :edit

    live "/:id", BandLive.Show, :show
    live "/:id/show/edit", BandLive.Show, :edit
  end

  scope "/spotify", BandOfTheWeekWeb.Spotify do
    pipe_through [:browser, :require_authenticated_user]

    get "/authorize", AuthorizationController, :authorize
    get "/authenticate", AuthenticationController, :authenticate

    # live "/", SpotifyLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", BandOfTheWeekWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  import Phoenix.LiveDashboard.Router

  scope "/" do
    if Mix.env() in [:dev, :test] do
      pipe_through :browser
    else
      pipe_through [:browser, :admins_only]
    end

    live_dashboard "/dashboard", metrics: BandOfTheWeekWeb.Telemetry
  end

  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp admin_basic_auth(conn, _opts) do
    username = System.fetch_env!("AUTH_USERNAME")
    password = System.fetch_env!("AUTH_PASSWORD")
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end

  ## Authentication routes

  scope "/", BandOfTheWeekWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", BandOfTheWeekWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", BandOfTheWeekWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
