class LoggedInController < ApplicationController
  before_filter :authenticate_group!
end
