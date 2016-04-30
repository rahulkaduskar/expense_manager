class GroupMembersController < ApplicationController
  # GET /group_members
  # GET /group_members.json
  def index
    @group_members = GroupMember.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_members }
    end
  end

  # GET /group_members/1
  # GET /group_members/1.json
  def show
    @group_member = GroupMember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_member }
    end
  end

  # GET /group_members/new
  # GET /group_members/new.json
  def new
    @group_member = GroupMember.new
    @group_member.group_id = params[:group_id]
    render :layout => false
  end

  # GET /group_members/1/edit
  def edit
    @group_member = GroupMember.find(params[:id])
  end

  # POST /group_members
  # POST /group_members.json
  def create
    @group_member = GroupMember.new(group_member_params(params))
    msg = nil
    email_regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
    if params[:user_email].present?     
      if email_regex.match(params[:user_email])   
        user = User.find_by_email_id(params[:user_email])
        if user.blank?
          user = User.new()
          user.email_id = params[:user_email]
          user.name = params[:user_email].slice(0, params[:user_email].index("@") )
          user.password = 'temp123'
          user.password_confirmation = 'temp123'
          user.save!
        end
        @group_member.user = user
      else
        user = User.find_by_name(params[:user_email])
        if user.blank?
          msg = "User not found."
        else
          @group_member.user_id = user.id
        end
      end
    else
      msg = "Please specify at user name or user email id."
      succes = false
    end

    if msg.blank?
      if @group_member.save
        msg =  'Group member was successfully created.'
        success = true
      else
        msg = @group_member.errors
        success = false
      end
    end
    render :update do |page|
      if(success)
        page.replace_html 'notice', "#{msg}"
        page << "jQuery('#notice').show();"
        page << "hideMessage(jQuery('#notice'));"
        page << "jQuery('#dialog').dialog('close');"
      else
        page << "jQuery('#error').html('#{msg}')"
        page << "jQuery('#error').show();"
      end
    end
  end

  # PUT /group_members/1
  # PUT /group_members/1.json
  def update
    @group_member = GroupMember.find(params[:id])

    respond_to do |format|
      if @group_member.update_attributes(params[:group_member])
        format.html { redirect_to @group_member, notice: 'Group member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_members/1
  # DELETE /group_members/1.json
  def destroy
    @group_member = GroupMember.find(params[:id])
    @group_member.destroy

    respond_to do |format|
      format.html { redirect_to group_members_url }
      format.json { head :no_content }
    end
  end

  def group_member_params(group_member_params)
    group_member_params[:group].permit(:group_id)
  end

end
