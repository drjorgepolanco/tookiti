class ContestsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only:                [:edit, :update, :destroy]

  def index
    @contests = Contest.all
  end

  def show
    @contest = Contest.find(params[:id])
  end

  def new
    @contest = Contest.new
  end

  def edit
  end

  def create
    @contest = current_user.contests.build(contest_params)
    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'your contest was successfully created' }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to @contest, notice: 'your contest was successfully updated' }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contest.destroy
    respond_to do |format|
      format.html { redirect_to contests_url, notice: 'your contest was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  private

    def correct_user
      @contest = current_user.contests.find_by(id: params[:id])
      if @contest.nil?
        redirect_to(root_url)
        flash[:warning] = "you can't update or delete somebody else's contests"
      end
    end

    def contest_params
      params.require(:contest).permit(:title, :poster, :description, :poll)
    end
end
