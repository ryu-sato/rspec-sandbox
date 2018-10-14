class DiffService
  include Singleton

  # 差分があればtrueを返し、なければfalseを返す
  def different?(comparing_base_file_or_dir, comparing_target_file_or_dir)
    option_string = '-q -I " *\/\/@->" -Bb'
    `diff #{option_string} #{comparing_base_file_or_dir} #{comparing_target_file_or_dir} 2>&1 > /dev/null`
    $?.exitstatus == 1
  end

  # diffファイルを作成する
  def generate_diff_file(comparing_base_file_or_dir, comparing_target_file_or_dir, diff_path_to_save, force_to_create_diff = false, diff_lines = 3)
    # 差分がなければdiffファイルを作成しない(強制作成フラグがあればその限りでない)
    return if (!force_to_create_diff && !different?(comparing_base_file_or_dir, comparing_target_file_or_dir))

    # ディレクトリが存在しない場合には作成
    # [memo] 必要？
    FileUtils.mkdir_p(comparing_target_file_or_dir) unless File.exists?(comparing_target_file_or_dir)

    # diffファイルを作成する
    option_string = "-I ' *\/\/@->' -u -U#{diff_lines} -Bb --exclude='BACKUP_RE-*' --exclude='*.log.bak'"
    `diff #{option_string} #{comparing_base_file_or_dir} #{comparing_target_file_or_dir} > #{diff_path_to_save}`
  end
end
