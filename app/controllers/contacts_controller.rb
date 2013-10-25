class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_owner, only:[:edit, :update, :destroy]
  # GET /contacts
  # GET /contacts.json
  def index
    if params[:user_id]
      @contacts = Contact.where(user_id: params[:user_id]).order('last_name').page(params[:page]).per(15)
    elsif params[:search]
      # @contacts = Contact.search(params[:search])
      @contacts = Kaminari.paginate_array(Contact.search(params[:search]), load:true).page(params[:page]).per(15)
    else
      @contacts = Contact.order('last_name').page(params[:page]).per(15)
    end
    
    respond_to  do |format|
      format.html
      format.csv {send_data Contact.order('last_name').to_csv }
      format.xls {send_data Contact.order('last_name').to_csv(col_sep: "\t") }
      format.js 
    end
  end

  def import
    if !params[:file].blank?
      Contact.import(params[:file])
      redirect_to contacts_url, notice:"Contacts imported."
    else
      redirect_to contacts_url, notice:"Please select a file to upload!"
    end
    
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render action: 'show', status: :created, location: @contact }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :middle_name, :last_name, :suffix, :company, :department, :job_title, :business_street, :business_city, :business_state, :business_zipcode, :business_fax, :business_phone, :business_phone2, :company_phone, :home_phone, :mobile_phone, :other_phone, :email, :website)
    end

    def is_owner
      if current_user.id != @contact.user_id
         flash[:notice] = "You can ONLY modify your own record!"
         redirect_to contacts_url
      end
    end
end
