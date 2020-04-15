# frozen_string_literal: true

class RodsController < ApplicationController
  before_action :set_rod, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  require 'will_paginate/array'
  # GET /rods
  # GET /rods.json
  def index
    @rods = if params[:rod] && params[:rod][:brand]
              Rod.search(params[:rod][:brand])
            else
              Rod.all
            end

    # @rods = Rod.all.order('created_at desc').paginate(page: params[:page], per_page: 4)

    # @rods = []
    # Rod.all.each do |_post|
    #   @rods.push(rod)
    # end
    # @rods = @rods.paginate(page: params[:page], per_page: 4)
  end

  def scrape
    url = 'https://www.cabelas.ca/category/casting-rods/622'
    response = Scraping.process(url)
    if response[:status] == :completed && response[:error].nil?
      flash.now[:notice] = 'Successfully scraped url'
    else
      flash.now[:alert] = response[:error]
    end
  rescue StandardError => e
    flash.now[:alert] = "Error: #{e}"
  end

  # GET /rods/1
  # GET /rods/1.json
  def show; end

  # GET /rods/new
  def new
    @rod = current_user.rods.build
  end

  # GET /rods/1/edit
  def edit; end

  # POST /rods
  # POST /rods.json
  def create
    @rod = current_user.rods.build(rod_params)

    respond_to do |format|
      if @rod.save
        format.html { redirect_to @rod, notice: 'Rod was successfully created.' }
        format.json { render :show, status: :created, location: @rod }
      else
        format.html { render :new }
        format.json { render json: @rod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rods/1
  # PATCH/PUT /rods/1.json
  def update
    respond_to do |format|
      if @rod.update(rod_params)
        format.html { redirect_to @rod, notice: 'Rod was successfully updated.' }
        format.json { render :show, status: :ok, location: @rod }
      else
        format.html { render :edit }
        format.json { render json: @rod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rods/1
  # DELETE /rods/1.json
  def destroy
    @rod.destroy
    respond_to do |format|
      format.html { redirect_to rods_url, notice: 'Rod was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @rods = Rod.where('brand LIKE ? OR title LIKE ? OR color LIKE ? OR size LIKE ?',
                      "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rod
    @rod = Rod.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def rod_params
    params.require(:rod).permit(:brand, :description, :stock_quantity, :title, :price, :color, :size, :image, :category_id)
  end
end
