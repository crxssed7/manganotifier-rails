class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["MANGA_NOTIFIER_HTTP_USER"], password: ENV["MANGA_NOTIFIER_HTTP_PASS"]
end
