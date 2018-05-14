# frozen_string_literal: true

class BsJwt::Railtie < Rails::Railtie
  rake_tasks do
    load 'bs_jwt/tasks/install.rake'
  end
end