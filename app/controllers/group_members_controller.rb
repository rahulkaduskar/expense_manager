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
    if(@group_member.save)
      render json { head :no_content }
    else
      render json: {  errors: @group_member.errors.full_messages, status: :unprocessable_entity }
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
        format.json { render json: { errors: @group_member.errors, status: :unprocessable_entity }}
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
    group_member_params[:group_member].permit(:group_id,:user_id)
  end

end
