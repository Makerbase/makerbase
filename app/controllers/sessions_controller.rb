# class SessionsController < ApplicationController
#
#   def create
#     client = Octokit::Client.new :access_token = auth_hash['credentials']['token']
#     if client.org_member?(ENV['ORG_NAME'], client.user.login)
#       redirect_to root_path, notice: 'You have successfully signed in!'
#     else
#       # redirect_to root_path
#       render 'new'
#     end
#   end
#
#   protected
#
#   def auth_hash
#     request.env[‘omniauth.auth’]
#   end
# end
