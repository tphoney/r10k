require 'r10k'
require 'r10k/module'
require 'r10k/synchro/git'

class R10K::Module::Git

  R10K::Module.register(self)

  def self.implements(name, args)
    args.is_a? Hash and args.has_key?(:git)
  rescue
    false
  end

  def initialize(name, path, args)
    @name, @path, @args = name, path, args

    @remote = @args[:git]
    @ref    = (@args[:ref] || 'master')
  end

  def sync!(options = {})
    synchro = R10K::Synchro::Git.new(@remote)
    synchro.sync(full_path, @ref, options)
  end

  private

  def full_path
    File.join(@path, @name)
  end
end