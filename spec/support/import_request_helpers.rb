module ImportRequestHelpers
  shared_context 'when requesting file' do
    before do
      stub_request(:get, 'https://challenges.coode.sh/food/data/json/index.txt').to_return(
        status: 200,
        body: "file1.txt\nfile2.txt".to_s
      )
    end
  end
end
