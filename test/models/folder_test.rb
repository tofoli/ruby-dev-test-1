require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  test 'root scope' do
    folders(:boot, :home, :clicksign, :images, :documents, :videos)

    assert_equal 6, Folder.count
    assert_equal 2, Folder.root.count
  end

  test 'same label in directory' do
    folders(:home)
    clicksign = folders(:clicksign)
    folders(:images)

    folder = Folder.new(folder: clicksign, label: 'Images')

    assert folder.invalid?
    assert_equal ['has already been taken'], folder.errors[:label]
  end

  test 'same label in another directory' do
    folders(:home, :clicksign, :images)
    boot = folders(:boot)

    folder = Folder.new(folder: boot, label: 'Images')

    assert folder.valid?
  end

  def create_files
    boot = folders(:boot)
    boot.files.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'one.jpg')),
      filename: 'one.jpg'
    )
    boot.files.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'two.jpeg')),
      filename: 'two.jpeg'
    )
    boot.files.attach(
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'three.jpg')),
      filename: 'three.jpg'
    )

    boot.save
    boot.reload
  end

  test 'add files' do
    boot = create_files

    assert boot.files.attached?
    assert_equal 3, boot.files.size

    assert_equal 'one.jpg', boot.files.first.filename.to_s
    assert_equal 'two.jpeg', boot.files.second.filename.to_s
    assert_equal 'three.jpg', boot.files.third.filename.to_s
  end

  test 'remove file' do
    boot = create_files

    assert boot.files.attached?
    assert_equal 3, boot.files.size

    boot.files.third.purge

    boot = boot.reload
    assert boot.files.attached?
    assert_equal 2, boot.files.size
  end

  test 'remove all file' do
    boot = create_files

    assert boot.files.attached?
    assert_equal 3, boot.files.size

    boot.files.third.purge
    boot.files.second.purge
    boot.files.first.purge

    boot = boot.reload
    assert_not boot.files.attached?
    assert_equal 0, boot.files.size
  end
end
