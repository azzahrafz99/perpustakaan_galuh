# This is shared example for user authentication for any controller spec
# Example of use:
# it_should_behave_like 'render index with error message'

shared_examples 'redirect to dashboard with error message' do
  it 'renders index' do
    expect(flash[:alert]).to eq 'You are not authorized to perform this action.'
    expect(response).to redirect_to(root_path)
  end
end
