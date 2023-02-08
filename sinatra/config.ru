require './app'
run SinatraApi::App

# Controllers V1
use Api::V1::CarsController
use Api::V1::UsersController

# Auth
use Api::Auth::AuthController