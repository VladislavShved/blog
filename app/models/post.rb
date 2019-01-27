class Post < ApplicationRecord
  belongs_to :user

  def self.create_with_author(post_params)
    post = nil

    ActiveRecord::Base.transaction do
      user = User.find_or_create_by(login: post_params[:user_login])
      post = Post.create(header: post_params[:header], content: post_params[:content], author_ip: post_params[:author_ip], user: user)
    end

    post
  end

  def self.vote_with(vote_params)
    post = Post.find(vote_params[:id])

    post.with_lock do
      Vote.create(post: post, mark: vote_params[:mark])
      if post.avg_vote.blank? || post.avg_vote == 0
        post.avg_vote = vote_params[:mark]
        post.marks_count = 1
      else
        post.avg_vote = ((post.avg_vote*post.marks_count + vote_params[:mark].to_i)*1.0)/(post.marks_count + 1)
        post.marks_count += 1
      end

      post.save!
    end

    post.avg_vote
  end
end