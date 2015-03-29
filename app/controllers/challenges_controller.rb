class ChallengesController < ApplicationController
  def new
  end

  def create
    @post = Post.find(params[:post_id])
    @contest = Contest.find(params[:contest_id])
    @challenge = @contest.challenges.create(post: @post)
  end
end
