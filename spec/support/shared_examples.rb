shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "requires admin" do
  it "redirects to the home path" do
    session[:user_id] = Fabricate(:user).id # kevin doesn't call .id here
    action
    expect(response).to redirect_to home_path
  end
end
