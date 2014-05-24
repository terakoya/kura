class StuffsController < ApplicationController
  before_action :set_stuff, only: [:show, :edit, :update, :destroy, :download]

  # GET /stuffs
  # GET /stuffs.json
  def index
    @stuffs = Stuff.all
    @stuff = Stuff.new
  end

  # GET /stuffs/1
  # GET /stuffs/1.json
  def show
  end

  # POST /stuffs
  # POST /stuffs.json
  def create
    @stuff = Stuff.new(stuff_params)

    respond_to do |format|
      if @stuff.save
        format.html { redirect_to @stuff, notice: 'Stuff was successfully created.' }
        format.json { render :show, status: :created, location: @stuff }
      else
        format.html { render :new }
        format.json { render json: @stuff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stuffs/1
  # DELETE /stuffs/1.json
  def destroy
    return render status: 404, text: 'Not Found' unless @stuff.password_digest

    if @stuff.authenticate(params[:password])
      @stuff.destroy
      respond_to do |format|
        format.html { redirect_to stuffs_url, notice: 'Stuff was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        flash[:error] = 'your password is incorrect.'
        format.html { render :show }
        format.json { head :forbidden }
      end
    end
  end

  def download
    send_file @stuff.filepath
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stuff
      @stuff = Stuff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stuff_params
      params.require(:stuff).permit(:title, :unlisted, :file, :password)
    end
end
