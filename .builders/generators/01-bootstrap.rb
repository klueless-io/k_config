
KManager.action :bootstrap do
  def on_action
    application_name = :k_config
    director = KDirector::Dsls::RubyGemDsl
      .init(k_builder,
        # on_exist:                   :skip,                      # %i[skip write compare]
        # on_action:                  :queue                      # %i[queue execute]
      )
      .data(
        ruby_version:               '2.7',
        application:                application_name,
        application_description:    'KConfig provides configuration for multi-plugin architecture',
        application_lib_path:       application_name.to_s,
        application_lib_namespace:  'KConfig',
        namespaces:                 ['KConfig'],
        author:                     'David Cruwys',
        author_email:               'david@ideasmen.com.au',
        avatar:                     'Developer',
        initial_semver:             '0.0.1',
        main_story:                 'As a Developer, I want a standard configuration interface for plugins, so that I can have consistent and extensible configuration with each om my GEMs',
        copyright_date:             '2022',
        website:                    'http://appydave.com/gems/k_config'
      )
      .github(
        repo_name: application_name.to_s
      ) do
        # create_repository
        # delete_repository
        # list_repositories
        # open_repository
        # run_command('git init')
      end
      .blueprint(
        name: :bin_hook,
        description: 'BIN/Hook structures',
        on_exist: :write) do

        cd(:app)

        # oadd('bin/runonce/git-setup.sh', dom: dom)
        # run_template_script('bin/runonce/git-setup.sh', dom: dom)

        # add('.githooks/commit-msg') #, template_subfolder: 'ruby', template_file: 'commit-msg')
        # add('.githooks/pre-commit') #, template_subfolder: 'ruby', template_file: 'pre-commit')

        # run_command('chmod +x .githooks/commit-msg')
        # run_command('chmod +x .githooks/pre-commit')

        # add('.gitignore')

        # add('bin/setup')
        # add('bin/console')

        # run_command('git config core.hooksPath .githooks') # enable sharable githooks (developer needs to turn this on before editing rep)
        # run_command("gh repo edit -d \"#{dom[:application_description]}\"")

        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      .blueprint(
        name: :opinionated,
        description: 'opinionated GEM files',
        on_exist: :write) do

        cd(:app)

        dd = OpenStruct.new(dom)

        # add("lib/#{dd.application}.rb"             , template_file: 'lib/applet_name.rb'         , dom: dom)
        # add("lib/#{dd.application}/version.rb"     , template_file: 'lib/applet_name/version.rb' , dom: dom)
    
        # add('spec/spec_helper.rb')
        # add("spec/#{dd.application}_spec.rb"       , template_file: 'spec/applet_name_spec.rb', dom: dom)

        # add("#{dd.application}.gemspec"            , template_file: 'applet_name.gemspec', dom: dom)
        # add('Gemfile', dom: dom)
        # add('Guardfile', dom: dom)
        # add('Rakefile', dom: dom)
        # add('.rspec', dom: dom)
        # add('.rubocop.yml', dom: dom)
        # add('README.md', dom: dom)
        # add('docs/CODE_OF_CONDUCT.md', dom: dom)
        # add('docs/LICENSE.txt', dom: dom)

        # run_command("rubocop -a")
      
        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      .blueprint(
        name: :ci_cd,
        description: 'github actions (CI/CD)',
        on_exist: :write) do

        cd(:app)

        # run_command("gh secret set SLACK_WEBHOOK --body \"$SLACK_REPO_WEBHOOK\"")
        # run_command("gh secret set GEM_HOST_API_KEY --body \"$GEM_HOST_API_KEY\"")
        # add('.github/workflows/main.yml')

        # add('package.json')

        # run_command('npm install -D --package-lock-only semantic-release')
        # run_command('npm install -D --package-lock-only @semantic-release/changelog')
        # run_command('npm install -D --package-lock-only @semantic-release/git')
        # run_command('npm install -D --package-lock-only https://github.com/klueless-js/semantic-release-rubygem')
        # add('.releaserc.json')

        run_command("git add .; git commit -m 'fix: #{self.options.description.downcase}'; git push")
      end

    # director.k_builder.debug
    director.play_actions
    # director.builder.logit
  end
end

KManager.opts.app_name                    = 'Boot Strap'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'

