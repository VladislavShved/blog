class Api::V1::PostsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    render json: { message: "title and content can't be empty" }, status: 422 if post_params[:header].blank? || post_params[:content].blank?

    post = Post.create_with_author(post_params)

    render json: { message: "Post not created" }, status: 422 unless post.present?

    render json: post, status: 200
  end

  def vote
    new_rating = Post.vote_with(vote_params)

    render json: { new_rating: new_rating }, status: 200
  end

  def top_posts
    result = Post.order(avg_vote: :desc).first(params[:count].to_i).to_a.map do |post|
      obj = {}
      obj[:title] = post.header
      obj[:content] = post.content
      obj
    end

    render json: result, status: 200
  end

  def multi_ip_list
    ips = Post.group(:author_ip).select('author_ip, COUNT(*) as authors').having('COUNT(*) > 1').map(&:author_ip)
    posts = Post.where(author_ip: ips).select('author_ip, user_id').to_a.group_by(&:author_ip)

    result = posts.keys.map do |ip|
      obj = {}
      obj[:author_ip] = ip
      obj[:user_ids] = posts[ip].map(&:user_id)
      obj
    end

    render json: result, status: 200
  end

  private

  def post_params
    params.require(:post).permit(:header, :content, :user_login, :author_ip)
  end

  def vote_params
    params.require(:post).permit(:id, :mark)
  end

end