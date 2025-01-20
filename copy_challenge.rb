require 'fileutils'

# Define paths
ENV_FILE = '.env'
CHALLENGES_DIR = './challenges'
COMMUNITY_DIR = './community'

##
# Reads the .env file or prompts the user for CURRENT_USER if missing.
# Stores it in .env if not found.
##
def get_or_set_current_user
  if File.exist?(ENV_FILE)
    env_content = File.read(ENV_FILE)
    if env_content.match(/^CURRENT_USER=(.+)/)
      return env_content.match(/^CURRENT_USER=(.+)/)[1]
    end
  end

  # Prompt user for input if CURRENT_USER is missing
  print "Digite seu nome de usuário: "
  user = gets.chomp
  File.open(ENV_FILE, 'a') { |file| file.puts "CURRENT_USER=#{user}" }
  puts "CURRENT_USER=#{user} foi salvo em #{ENV_FILE}."
  user
end

##
# Returns a Hash of all possible challenges.
# - Key:   The challenge name the user will type (e.g. "lasagna", "2.instance_variables").
# - Value: The path *relative* to CHALLENGES_DIR (e.g. "0.basics/lasagna", "2.instance_variables").
#
# Behavior:
#  - If a category (e.g., "0.basics") has subfolders, those subfolders are separate challenges.
#  - If a category (e.g., "2.instance_variables") has no subfolders but **does** contain files,
#    that category itself is a challenge.
#  - If a category is empty (or only has non-challenge files) and no subfolders, it is skipped.
##
def list_challenges
  challenges = {}

  # Get all top-level directories inside ./challenges
  categories = Dir.entries(CHALLENGES_DIR).select do |entry|
    File.directory?(File.join(CHALLENGES_DIR, entry)) && !['.', '..'].include?(entry)
  end

  categories.each do |category|
    category_path = File.join(CHALLENGES_DIR, category)

    # Sub-folders inside this category
    subdirs = Dir.entries(category_path).select do |entry|
      File.directory?(File.join(category_path, entry)) && !['.', '..'].include?(entry)
    end

    if subdirs.any?
      # This category has one or more sub-challenges
      subdirs.each do |subdir|
        challenges[subdir] = File.join(category, subdir)
      end
    else
      # No subdirectories => check if this folder has files
      files_in_category = Dir.entries(category_path).reject do |f|
        File.directory?(File.join(category_path, f))
      end

      # If it has at least one file, treat the category itself as a challenge
      unless files_in_category.empty?
        challenges[category] = category
      end
    end
  end

  challenges
end

def main
  current_user = get_or_set_current_user

  # List challenges
  puts "Desafios disponíveis:"
  challenges = list_challenges
  challenges.each_key { |challenge| puts " - #{challenge}" }

  print "Digite o nome do desafio que deseja copiar: "
  challenge_name = gets.chomp.strip

  # Validate challenge name
  unless challenges.key?(challenge_name)
    puts "Erro: Nenhum desafio encontrado com o nome '#{challenge_name}'."
    return
  end

  # Paths
  relative_challenge_path = challenges[challenge_name]  # e.g. "0.basics/lasagna" or "2.instance_variables"
  source_path = File.join(CHALLENGES_DIR, relative_challenge_path)
  target_path = File.join(COMMUNITY_DIR, current_user, relative_challenge_path)

  # Ensure the target directory exists
  FileUtils.mkdir_p(target_path)

  # Copy only the contents of the source folder into the target folder
  FileUtils.cp_r("#{source_path}/.", target_path)

  puts "O desafio '#{challenge_name}' foi copiado com sucesso para '#{target_path}'."
end

# Execute script
main