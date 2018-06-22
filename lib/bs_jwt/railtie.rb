# frozen_string_literal: true

module BsJwt
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'bs_jwt/tasks/install.rake'
    end
  end
end
