class Stuff < ActiveRecord::Base
  validates :filename, presence: true

  def file
  end

  def file=(file)
    self.filename = create_filename(file)
    File.binwrite self.filepath, file.read
  end

  def filepath
    File.join(Rails.application.secrets.files_dir,
              File.basename(self.filename.to_s))
  end

  private

  def create_filename(file)
    ext = File.extname(file.original_filename)
    "#{Time.now.strftime("%Y%m%d-%H%M%S")}-" \
    "#{rand(1000000).to_s(16)}#{ext}"
  end
end
