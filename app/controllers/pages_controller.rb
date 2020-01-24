class PagesController < ApplicationController
  layout "main"
  def root
    render template: "./main/root"
  end
end
