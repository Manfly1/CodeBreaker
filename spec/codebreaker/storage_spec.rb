# frozen_string_literal: true

RSpec.describe Codebreaker::Storage do
  let(:directory_path) { 'Codebreaker::Storage::FILE_DIRECTORY' }
  let(:filename) { 'Codebreaker::Storage::FILE_NAME' }

  describe 'instance creation' do
    context 'when db initialized' do
      let(:fixtures_directory_path) { 'spec/codebreaker/fixtures' }
      let(:fixtures_filename) { 'test.yml' }

      before do
        stub_const(directory_path, fixtures_directory_path)
        stub_const(filename, fixtures_filename)
      end

      it 'can load users statistics' do
        store = described_class.new
        expect(store.data[:user_statistics])
      end
    end

    context 'when db is not initialized' do
      let(:initialized_directory_path) { 'test_db' }
      let(:initialized_filename) { 'test.yml' }

      before do
        stub_const(directory_path, initialized_directory_path)
        stub_const(filename, initialized_filename)
      end

      after do
        File.delete(File.join(initialized_directory_path, initialized_filename))
        Dir.rmdir(initialized_directory_path)
      end
    end
  end

  describe '#save' do
    let(:saving_directory_path) { '' }
    let(:saving_filename) { 'saved_user_statistics.yml' }
    let(:user) { Codebreaker::User.new(Faker::Name.first_name) }
    let(:difficulty) { Codebreaker::Difficulty.new(name: 'Easy', attempts: 10, hints: 5) }
    let(:attempts) { 3 }
    let(:hints) { 2 }

    before do
      stub_const(directory_path, saving_directory_path)
      stub_const(filename, saving_filename)
    end

    after do
      File.delete(File.join(saving_directory_path, saving_filename))
      Dir.rmdir(saving_directory_path)
    end
  end
end
