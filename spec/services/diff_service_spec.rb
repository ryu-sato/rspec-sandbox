require 'rails_helper'

# Service のテストを実施するときには、type: :service を指定する
describe DiffService, type: :service do
  let(:diff_service) { DiffService.instance }

  describe '#different?' do
    let(:files) { [
      { name: 'same0', content: 'abc' },
      { name: 'same1', content: 'abc' },
      { name: 'diff', content: 'hoge' },
    ]}

    around(:each) do |test|
      @file_paths = []
      Dir.mktmpdir do |tmpdir|
        3.times do |i|
          @file_paths.push(File.join(tmpdir, files[i][:name]))
          File.open(@file_paths[i], 'w') {|f| f.puts(files[i][:content])}
        end

        test.run
      end
    end

    context 'when files are same' do
      it 'return false' do
        expect(diff_service.different?(@file_paths[0], @file_paths[1])).to eq(false)
      end
    end

    context 'when files are different' do
      it 'return true' do
        expect(diff_service.different?(@file_paths[0], @file_paths[2])).to eq(true)
      end
    end
  end

  describe '#generate_diff_file' do
    let(:files) { [
      { name: 'same', content: 'abc' },
      { name: 'same', content: 'abc' },
      { name: 'diff', content: 'hoge' },
    ]}

    # 比較対象用のディレクトリを 3 つ作成して dir_paths を初期化し、
    # 差分ファイル保管用のディレクトリを作成してファイルパスを diff_file_path に設定する
    around(:each) do |test|
      Dir.mktmpdir do |comp_dir1|
        Dir.mktmpdir do |comp_dir2|
          Dir.mktmpdir do |comp_dir3|
            @dir_paths = [comp_dir1, comp_dir2, comp_dir3]

            3.times do |i|
              File.open(File.join(@dir_paths[i], files[i][:name]), 'w') {|f| f.puts(files[i][:content])}
            end

            Dir.mktmpdir do |store_dir|
              @diff_file_path = File.join(store_dir, 'result.diff')

              test.run
            end
          end
        end
      end
    end

    context 'when directories different and called with option force_to_create_diff false' do
      it 'should generate diff file' do
        diff_service.generate_diff_file(@dir_paths[0], @dir_paths[2], @diff_file_path, false)
        expect(File.exists?(@diff_file_path)).to eq(true)
      end
    end

    context 'when directories same and called with option force_to_create_diff false' do
      it 'should not generate diff file' do
        diff_service.generate_diff_file(@dir_paths[0], @dir_paths[1], @diff_file_path, false)
        expect(File.exists?(@diff_file_path)).to eq(false)
      end
    end

    context 'when directories same and called with option force_to_create_diff true' do
      it 'should generate diff file' do
        diff_service.generate_diff_file(@dir_paths[0], @dir_paths[1], @diff_file_path, true)
        expect(File.exists?(@diff_file_path)).to eq(true)
      end
    end
  end
end
