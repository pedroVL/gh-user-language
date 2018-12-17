require 'open-uri'

class SearchesController < ApplicationController

  def search
  end

  def result
    user = params_set
    @search = {username: user[:username], avatar: user[:avatar], repos: user[:repos], total: user[:total]}
  end

  private

  def params_set
    url = "https://api.github.com/users/#{params[:search]}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    username = user['login']
    avatar = user['avatar_url']

    repo_url = "https://api.github.com/users/#{params[:search]}/repos"
    repos_serialized = open(repo_url).read
    all_repos = JSON.parse(repos_serialized)

    repos = []
    total = {}
    all_repos.each do |repo|
      language_url = "https://api.github.com/repos/#{params[:search]}/#{repo["name"]}/languages"
      languages_serialized = open(language_url).read
      languages = JSON.parse(languages_serialized)

      repos << {
        name: repo["name"],
        main_language: repo["language"],
        languages: languages
      }

      languages.each do |language, value|
        if !total.key?(language)
          total[language] = value
        else
          total[language] += value
        end
      end
    end
    { username: username, avatar: avatar, repos: repos, total: total.sort_by { |_key, value| -value } }
  end
end
