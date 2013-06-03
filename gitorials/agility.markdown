


<a name='intro'> </a>


The Agility Tutorial - A simple story manager
{: .document-title}

Contents
{: .contents-heading}

- contents
{:toc}

# Introduction

In this tutorial we'll be creating a simple "Agile Development"
application -- _Agility_. The application tracks projects which
consist of a number of user stories. Stories have a status
(e.g. accepted, under development...) as well as a number of
associated tasks. Tasks can be assigned to users, and each user can
see a heads-up of all the tasks they've been assigned to on their home
page.

This is a bit of an in-at-the-deep-end tutorial -- we build the app
the way you would assuming you had already got the hang of the way
Hobo works. In the later stages new concepts start coming thick and
fast. The goal here is to show you what's possible, and give you a
flavour of Hobo-style application development, rather than to provide
detailed background on how everything works. Don't worry about it,
it's fun! If you'd rather take things a bit slower, you might prefer
the Hobo book (insert link here).


# Getting Started


## Introduction to Hobo

Hobo is a bunch of extensions to Ruby on Rails that are designed to
make developing any kind of web application a good deal faster and
more fun. This tutorial is designed to show off Hobo's ability to get
quite sophisticated applications up and running extremely quickly.

While Hobo is very well suited to this kind of
throw-it-together-in-an-afternoon application, it is equally useful
for longer term projects, where the end result needs to be very
meticulously crafted to the needs of its users. Hopefully the tutorial
will give you an idea of how to take your Hobo/Rails application much
further.

For more info on Hobo please see [hobocentral.net](http://hobocentral.net)

## This is a gitorial

This is a 'gitorial', a tutorial made with [git](http://git-scm.org).
However, we highly recommend that you treat this as you would any
other tutorial.  The more that you put into the tutorial, the more you
will get out of it.  If you wish to use 'git' to follow along, see the
[sidebar](gitorial).  Using git will allow you to skip ahead
in the tutorial and to use git to double check your code for errors.
We do not recommend learning git and Hobo simultaneously, though.

[sidebar: using git with the tutorial](gitorial)

### How code is displayed in this tutorial

Code changes in this gitorial are displayed in a modified *patch*
format.  When you see one of these, they indicate how you should
modify the code in your version of this project.   Lines that have a
"+" in the left hand column and are coloured green indicate lines that
you should add to your project.   Lines to remove have a "-" in the
left hand column and are coloured red.

On the other hand, if you see something that looks like code but has a
"$" in the left hand column -- those aren't patches!  Those are
commands that you can type into your command terminal.


gitorial-001: [view on github](http://github.com/Hobo/agility-gitorial/commit/1a405315179acc31297fd4af0e7f1e681a1abf00), [download patch](http://github.com/Hobo/agility-gitorial/commit/1a405315179acc31297fd4af0e7f1e681a1abf00.patch)
{: .commit}




<a name='run-hobo'> </a>


## Before you start

You'll need a working Ruby on Rails setup. We're assuming you know at
least the basics of Rails. If not, you should probably work through a
Rails tutorial before attempting this one.

## Create the application with Hobo gem

Although Hobo is in fact a group of Rails plugins, it is also
available as a gem which gives you the useful `hobo` command:

    $ gem install hobo --pre

The `hobo` command is like the `rails` command, it can create a new
blank Rails app that is set-up for Hobo, as well as performing several
other tasks.  When you run the command, it will ask you many
questions.   For now, answer exactly as we do.

    $ hobo new agility
    Hobo Command Line Interface 2.0.0.pre8
    Generating Rails infrastructure...
          create
          create  README.rdoc
          create  Rakefile

... snip ...

     Hobo Setup Wizard
      Do you want to start the Setup Wizard now?
    (Choose 'n' if you need to manually customize any file before running the Wizard.
    You can run it later with `hobo g setup_wizard` from the application root dir.) [y|n]

Choose yes here to pull in Hobo.

     User Resource
    Choose a name for the user resource: [<enter>=user|<custom_name>]

Press enter to leave the name of the user model as `user`.

    Do you want to send an activation email to activate the user? [y|n] y

Press `y` here because that's a useful feature we'll use.

     Invite Only Option
    Do you want to add the features for an invite only website? [y|n] n

We're not building an invite-only website, so we'll press `n` here.


     Templates Option
    Will your application use only hobo/dryml web page templates?
    (Choose 'n' only if you also plan to use plain rails/erb web page templates) [y|n] y

Press `y` here because we're building a pure Hobo application.

     Test Framework
    Do you want to customize the test_framework? [y|n] n

Choose no -- we'll use the default test framework, Test::Unit.  It's easy enough to select a different test framework later if you change your mind.

     Front Controller
    Choose a name for the front controller: [<enter>=front|<custom_name>]

Press enter to leave the default front controller name as `front`.


     Front Theme
    The currently available themes are clean, clean_admin, clean_sidemenu and bootstrap.
    Choose a theme for the front site: [<enter>=bootstrap|<custom_name>]

Press enter to choose the default Hobo theme, bootstrap.

     Front jQuery-UI Theme
    The currently available jQuery-UI themes are listed here: https://github.com/fatdude/jquery-ui-themes-rails/blob/master/README.markdown
    Choose a jQuery-UI theme for the front site: [<enter>=redmond|<custom_name>]

Press enter to select the default jQuery-UI theme, redmond.  jQuery-UI is not used very much with the bootstrap theme and may be [removed later](http://hobocentral.net/blog/2012/12/21/using-hobo-2-0-without-jquery-ui/).

     Admin Subsite
    Do you want an admin subsite? [y|n] n

A subsite in Hobo is a separate collection of views and controllers routed independently.  Each subsite can have a different theme.   They're easy enough to add later via the [admin_subsite](/manual/generators/admin_subsite) or [subsite](/manual/generators/subsite) generators so we won't add one now.

     DB Migration
    Initial Migration: [s]kip, [g]enerate migration file only, generate and [m]igrate: [s|g|m] m

Press `m` here.   There's a lot going on underneath the hood here, but
we'll get to that later.

     I18n
    The Hobo supported locales are de en es fr it nb pt-PT ru (please, contribute to more translations)
    Type the locales (space separated) you want to add to your application or <enter> for 'en':

Press enter here to choose English.

      => "en"

     Git Repository
    Do you want to initialize a git repository now? [y|n] y
    Do you want git to ignore the auto-generated files?
    (Choose 'n' only if you are planning to deploy on a read-only File System like Heroku) [y|n] y

Choose `y` to both of these questions to put your project into Git.
Even if you don't know git you can still say "yes" here -- maybe
you'll find it useful in the future.

## Run the app

You should now have a complete bare bones application.   Fire it up
and give it a try!

    $ cd agility
    $ rails server


gitorial-003: [view on github](http://github.com/Hobo/agility-gitorial/commit/6c148d33e3953aea7ea95890205a455a332d9b82), [download patch](http://github.com/Hobo/agility-gitorial/commit/6c148d33e3953aea7ea95890205a455a332d9b82.patch)
{: .commit}




<a name='interface-first-hobo-style'> </a>

## Interface first Hobo style

The next thing we're going to do is sketch out our models. If you're a fully signed up devotee of the Rails Way, that should ring a few alarm bells. What happened to [interface first](http://gettingreal.37signals.com/ch09_Interface_First.php)? We do believe in Interface First. Absolutely. But for Hobos, interface first means first priority, not first task.

The reason is, we think we've rewritten this rule:

> Design is relatively light. A paper sketch is cheap and easy to change. html designs are still relatively simple to modify (or throw out). That's not true of programming. Designing first keeps you flexible. Programming first fences you in and sets you up for additional costs.

In our experience, experimenting with an app by actually building a prototype with Hobo, is actually quicker than creating html designs. How's that for getting real? We could waffle for a good while on this point, but that's probably best saved for a blog post. For now let's dive in and get this app running.


# The models

Let's review what we want this app to do:

 * Track multiple projects
 * Each having a collection of stories
 * Stories are just a brief chunk of text
 * A story can be assigned a current status and a set of outstanding tasks
 * Tasks can be assigned to users
 * Users can get an easy heads up of the tasks they are assigned to

Sounds to me like we just sketched a first-cut of our models. We'll start with:

 * `Project` (with a name)
	has many stories
 * `Story` (with a title, description and status)
	belongs to a project
	has many tasks
 * `Task` (with a description)
	belongs to a story
	has many users (through task-assignments)
 * `User` (we'll stick with the standard fields provided by Hobo)
	has many tasks (through task-assignments)

Hopefully the connection between the goal and those models is clear. If not, you'll probably find it gets easier once you've done it a few times. Before long you'll be throwing models into your app without even stopping to write the names down. Of course -- chances are you've got something wrong, made a bad decision. So? Just throw them away and create some new ones when the time comes. We're sketching here!

Here's how we create these with a Hobo generator:

	$ hobo generate resource project name:string
	$ hobo generate resource story   title:string body:text status:string
	$ hobo generate resource task    description:string

Task assignments are just a back-end model. They don't need a controller, so:

	$ hobo generate model task_assignment


gitorial-004: [view on github](http://github.com/Hobo/agility-gitorial/commit/a91632278ffa6b62de5ba3fa5717f95ee3aa3171), [download patch](http://github.com/Hobo/agility-gitorial/commit/a91632278ffa6b62de5ba3fa5717f95ee3aa3171.patch)
{: .commit}




<a name='add-initial-associations'> </a>

The field declarations have been created by the generators, but not the associations. Go ahead and add the associations, just below the `fields do ... end` declaration in each model, as follows:

    ::: app/models/project.rb
    @@ -2,13 +2,16 @@
     
       hobo_model # Don't put anything above this
     
       fields do
         name :string
    +    stories_count :integer, :default => 0, :null => false
         timestamps
       end
    -  attr_accessible :name
    +  attr_accessible :name, :stories
    +
    +  has_many :stories, :dependent => :destroy, :inverse_of => :project
     
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
    ::: app/models/story.rb
    @@ -4,13 +4,18 @@
     
       fields do
         title  :string
         body   :text
         status :string
    +    tasks_count :integer, :default => 0, :null => false
         timestamps
       end
    -  attr_accessible :title, :body, :status
    +  attr_accessible :title, :body, :status, :project, :project_id, :tasks
    +
    +  belongs_to :project, :inverse_of => :stories, :counter_cache => true
    +
    +  has_many :tasks, :dependent => :destroy, :inverse_of => :story
     
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
    ::: app/models/task.rb
    @@ -4,11 +4,16 @@
     
       fields do
         description :string
         timestamps
       end
    -  attr_accessible :description
    +  attr_accessible :description, :story, :story_id, :task_assignments, :users
    +
    +  belongs_to :story, :inverse_of => :tasks, :counter_cache => true
    +
    +  has_many :task_assignments, :dependent => :destroy, :inverse_of => :task
    +  has_many :users, :through => :task_assignments
     
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
    ::: app/models/task_assignment.rb
    @@ -3,11 +3,14 @@
       hobo_model # Don't put anything above this
     
       fields do
         timestamps
       end
    -  attr_accessible 
    +  attr_accessible :user, :user_id, :task, :task_id
    +
    +  belongs_to :user, :inverse_of => :task_assignments
    +  belongs_to :task, :inverse_of => :task_assignments
     
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
    ::: app/models/user.rb
    @@ -6,11 +6,16 @@
         name          :string, :required, :unique
         email_address :email_address, :login => true
         administrator :boolean, :default => false
         timestamps
       end
    -  attr_accessible :name, :email_address, :password, :password_confirmation
    +  attr_accessible :name, :email_address, :password, :password_confirmation, :task_assignments, :tasks
    +
    +  validates_presence_of :name
    +
    +  has_many :task_assignments, :dependent => :destroy, :inverse_of => :user
    +  has_many :tasks, :through => :task_assignments
     
       # This gives admin rights and an :active state to the first sign-up.
       # Just remove it if you don't want that
       before_create do |user|
         if !Rails.env.test? && user.class.count == 0
    
{: .diff}


We're also adding counter\_cache columns to make it easier to sort on the count.


gitorial-005: [view on github](http://github.com/Hobo/agility-gitorial/commit/34ba61c790c619ac7930bee38e899b116ccddbc4), [download patch](http://github.com/Hobo/agility-gitorial/commit/34ba61c790c619ac7930bee38e899b116ccddbc4.patch)
{: .commit}




<a name='migration-to-create-initial-models'> </a>

Now watch how Hobo can create a single migration for all of these:

    $ hobo generate migration

When the migration generator asks you

    What now: [g]enerate migration, generate and [m]igrate now or [c]ancel?

Choose `m` to both generate the migration and apply it to your
database.   We entered `initial_models` as the name for our
migration.

Now you can start your application

    $ rails server

You can access it via your web browser at `http://localhost:3000`.
It's not a polished UI of course, but we do actually have a working
application. Make sure you are logged in as an administrator (e.g. the
user who signed up first), and spend a few minutes populating the app
with projects, stories and tasks.

With some more very simple changes, and without even touching the
views, we can get surprisingly close to a decent UI.


gitorial-006: [view on github](http://github.com/Hobo/agility-gitorial/commit/94b31ebe0332ca7b5894fa6d56aee925fde1d7cc), [download patch](http://github.com/Hobo/agility-gitorial/commit/94b31ebe0332ca7b5894fa6d56aee925fde1d7cc.patch)
{: .commit}




<a name='viewhints-children'> </a>

# Specifying view relationships

If we tell Hobo which has\_many relationships are significant, Hobo adjusts to display the list of children on its parent's page.

We added five has\_many relationships, but only two of them are significant, for now.  We specify these in the model file for the parent.

    ::: app/models/project.rb
    @@ -9,10 +9,12 @@
       end
       attr_accessible :name, :stories
     
       has_many :stories, :dependent => :destroy, :inverse_of => :project
     
    +  children :stories
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    ::: app/models/story.rb
    @@ -13,10 +13,12 @@
     
       belongs_to :project, :inverse_of => :stories, :counter_cache => true
     
       has_many :tasks, :dependent => :destroy, :inverse_of => :story
     
    +  children :tasks
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    
{: .diff}



gitorial-007: [view on github](http://github.com/Hobo/agility-gitorial/commit/2758cf7f269814bd0da55616d222fe736d6435c3), [download patch](http://github.com/Hobo/agility-gitorial/commit/2758cf7f269814bd0da55616d222fe736d6435c3.patch)
{: .commit}




<a name='remove-project-actions'> </a>

# Removing actions

By default Hobo has given us a full set of restful actions for every single model/controller pair. Many of these routes are inappropriate for our application. For example, why would we want an index page listing every Task in the database? We only really want to see tasks listed against stories and users. We need to disable the routes we don't want.

There's an interesting change of approach here that often crops up with Hobo development. Normally you'd expect to have to build everything yourself. With Hobo, you often get given everything you want and more besides. Your job is to take away the parts that you *don't* want.

Here's how we would remove, for example, the index action from TasksController. In `app/controllers/tasks_controller.rb`, change

    ::: app/controllers/tasks_controller.rb
    @@ -1,7 +1,7 @@
     class TasksController < ApplicationController
     
       hobo_model_controller
     
    -  auto_actions :all
    +  auto_actions :all, :except => :index
     
     end
    
{: .diff}


Refresh the browser and you'll notice that Tasks has been removed from the main nav-bar. Hobo's page generators adapt to changes in the actions that you make available.


gitorial-008: [view on github](http://github.com/Hobo/agility-gitorial/commit/adbccb5a6926430bdd228701f0d77a3c97af874c), [download patch](http://github.com/Hobo/agility-gitorial/commit/adbccb5a6926430bdd228701f0d77a3c97af874c.patch)
{: .commit}




<a name='auto-actions-for-project'> </a>

Here's another similar trick. Browse to one of your projects. You'll see the page says "No stories to display" but there's no way to add one. Hobo has support for this but we need to switch it on. Add the following declaration to the stories controller:

    ::: app/controllers/stories_controller.rb
    @@ -2,6 +2,8 @@
     
       hobo_model_controller
     
       auto_actions :all
     
    +  auto_actions_for :project, [:new, :create]
    +
     end
    
{: .diff}


This creates nested routes and their corresponding actions:

 - `/project/123/stories/new` routed to `StoriesController#new_for_project`
 - `/project/123/stories` (POST) routed to `StoriesController#create_for_project`

Hobo's page generators will respond to the existence of these routes and add a "New Story" link to the project page, and an appropriate "New Story" page.


gitorial-009: [view on github](http://github.com/Hobo/agility-gitorial/commit/e19adc16fcfc250c98a8190a6a4dd2051fc39ca6), [download patch](http://github.com/Hobo/agility-gitorial/commit/e19adc16fcfc250c98a8190a6a4dd2051fc39ca6.patch)
{: .commit}




<a name='auto-actions-for-story'> </a>

Create a story and you'll see the story has the same issue with it's task - there's no way to create one. Again we can add the `auto_actions_for` declaration to the tasks controller, but this time we'll only ask for a `create` action and not a `new` action:

    ::: app/controllers/tasks_controller.rb
    @@ -2,6 +2,8 @@
     
       hobo_model_controller
     
       auto_actions :all, :except => :index
     
    +  auto_actions_for :story, :create
    +
     end
    
{: .diff}


Hobo's page generator can cope with the lack of a 'New Task' page -- it gives you an in-line form on the story page.


gitorial-010: [view on github](http://github.com/Hobo/agility-gitorial/commit/29590e3908f674c234acb20f1cec0e20b7ffc97e), [download patch](http://github.com/Hobo/agility-gitorial/commit/29590e3908f674c234acb20f1cec0e20b7ffc97e.patch)
{: .commit}




<a name='more-auto-actions'> </a>

We'll now continue and configure the available actions for all of the controllers. So far we've seen the black-list style where you list what you *don't* want:

    auto_actions :all, :except => :index
{: .ruby}

There's also white-list style where you list what you do want, e.g.

    auto_actions :index, :show
{: .ruby}

There's also a handy shortcut to get just the read-only routes (i.e. the ones that don't modify the database)

	auto_actions :read_only
{: .ruby}

The opposite is handy for things that are manipulated by ajax but never viewed directly:

	auto_actions :write_only # short for -- :create, :update, :destroy
{: .ruby}

Work through your controllers and have a think about which actions you want. You need to end up with:

    ::: app/controllers/stories_controller.rb
    @@ -1,9 +1,9 @@
     class StoriesController < ApplicationController
     
       hobo_model_controller
     
    -  auto_actions :all
    +  auto_actions :all, :except => :index
     
       auto_actions_for :project, [:new, :create]
     
     end
    ::: app/controllers/tasks_controller.rb
    @@ -1,9 +1,9 @@
     class TasksController < ApplicationController
     
       hobo_model_controller
     
    -  auto_actions :all, :except => :index
    +  auto_actions :write_only, :edit
     
       auto_actions_for :story, :create
     
     end
    
{: .diff}


Have a play with the application with this set of actions in place. Looking pretty good!


gitorial-011: [view on github](http://github.com/Hobo/agility-gitorial/commit/cd3e25f9d50c4f7d357922f6a7dc27b1cd27e3d6), [download patch](http://github.com/Hobo/agility-gitorial/commit/cd3e25f9d50c4f7d357922f6a7dc27b1cd27e3d6.patch)
{: .commit}




<a name='permissions-1'> </a>

# Permissions

So far we've only done two things to our app: created some models & controllers, and specified which actions are available. There's one more thing we typically do when creating a new Hobo app, before we even touch the view layer. We modify permissions in the model layer.

## Introduction to permissions

You might have noticed methods like this one in the generated models:

	def create_permitted?
	  acting_user.administrator?
	end
{: .ruby}

That tells Hobo that only administrators are allowed to create this kind of model. Before every create, update and delete (destroy) operation, Hobo's controller calls one of these methods with `acting_user` set to the logged in user. Only if the method returns true is the operation allowed to continue.

Furthermore, the *Rapid* DRYML tag library (that's the part of Hobo that creates the UI automatically for you) knows how to interrogate the permissions and adapt accordingly. For example, Rapid will only generate a "New Project" link if the current user has permission to create a project.

You can see this feature in action by changing user (use the "user changer" menu in the top left) as you browse around the app. You'll notice that all the 'new' and 'edit' links disappear if you are a guest. If you experiment by changing `acting_user.administrator?` to `true` in some permission methods, you'll see operations start to become available.


## Customise the permissions in Agility

For the purposes of the tutorial you can make your own decisions about who should be allowed to do what. In the spirit of agile methods, we probably don't want to lock things down too much. Here's a suggestion:

 * Only administrators can create, edit and delete projects
 * Stories and tasks are open to change by all signed up users.

A permission that says "only signed up users" looks like this:

	def create_permitted?
	  acting_user.signed_up?
	end
{: .ruby}

(Note: there is also `acting_user.guest?`)

You might need to sign up a new user so you've got a non-admin to test
things with.  Remember that when we generated our application, we
asked the generator to send an activation email for new emails.  We
haven't configured an email server yet, so these emails are generated
but not delivered.   Luckily, they are copied into your log file, so
you can cut and paste the activation link for new emails from you log
file into a web browser to activate accounts.


gitorial-012: [view on github](http://github.com/Hobo/agility-gitorial/commit/9b4d4a275a42192164586298b73248f2a64e48c5), [download patch](http://github.com/Hobo/agility-gitorial/commit/9b4d4a275a42192164586298b73248f2a64e48c5.patch)
{: .commit}




<a name='permissions-for-data-integrity'> </a>

## Permissions for data integrity

The permissions system is not just for providing operations to some users but not to others. It is also used to prevent operations that don't make sense for anyone. For example, you've probably noticed that the default UI allows stories to be moved from one project to another. That's arguably not a sensible operation for *anyone* to be doing. Before we fix this, browse to an "Edit Story" page and notice the menu that lets you choose a different project. Now prevent the project from changing with this method in `story.rb`:

    ::: app/models/story.rb
    @@ -22,11 +22,11 @@
       def create_permitted?
         acting_user.administrator?
       end
     
       def update_permitted?
    -    acting_user.signed_up?
    +    acting_user.signed_up? && !project_changed?
       end
     
       def destroy_permitted?
         acting_user.administrator?
       end
    ::: app/models/task.rb
    @@ -18,11 +18,11 @@
       def create_permitted?
         acting_user.administrator?
       end
     
       def update_permitted?
    -    acting_user.signed_up?
    +    acting_user.signed_up? && !story_changed?
       end
     
       def destroy_permitted?
         acting_user.administrator?
       end
    
{: .diff}


Refresh the browser and you'll see that menu removed from the form automatically.

The `update_permitted?` method can take advantage of the "dirty tracking" features in ActiveRecord. If you're savvy with ActiveRecord you might notice something unusual there - those `*_changed?` methods are only available on primitive fields. Hobo's model extensions give you methods like that for `belongs_to` associations too.

Now make a similar change to prevent tasks being moved from one story to another.


gitorial-013: [view on github](http://github.com/Hobo/agility-gitorial/commit/17f49468a6fbb46cc1521859034d0fb9060dceee), [download patch](http://github.com/Hobo/agility-gitorial/commit/17f49468a6fbb46cc1521859034d0fb9060dceee.patch)
{: .commit}




<a name='permissions-associations'> </a>

## Associations

Although we have modelled the assignment of tasks to users, at the moment there is no way for the user to set these assignments. We'll add that to the task edit page. Create a task and browse to the edit page - only the description is editable. Hobo does provide support for "multi-model" forms, but it is not active by default. To specify that a particular association should be accessible to updates from the form, you need to declare `:accessible => true` on the association. In `task.rb`, edit the `has_many :users` association as follows:

    ::: app/models/task.rb
    @@ -9,11 +9,11 @@
       attr_accessible :description, :story, :story_id, :task_assignments, :users
     
       belongs_to :story, :inverse_of => :tasks, :counter_cache => true
     
       has_many :task_assignments, :dependent => :destroy, :inverse_of => :task
    -  has_many :users, :through => :task_assignments
    +  has_many :users, :through => :task_assignments, :accessible => true, :dependent => :destroy
     
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
    
{: .diff}


Without that declaration, the permission system was reporting that
this association was not editable. Now that the association is
"accessible", the permission system will check for create and destroy
permission on the join model `TaskAssignment`. As long as the current
user has those permissions, the task edit page should now include a
nice javascript powered control for assigning users in the edit-task
page.

Right now the only people who have this permission are the site
administrators.  (The first user who signs up automatically becomes
a site administrator).  We'll add permissions for other users later on
in [Project Ownership](#project_ownership).


gitorial-014: [view on github](http://github.com/Hobo/agility-gitorial/commit/acab58e687c8d8c04802c6d52b76371ed6dedac5), [download patch](http://github.com/Hobo/agility-gitorial/commit/acab58e687c8d8c04802c6d52b76371ed6dedac5.patch)
{: .commit}




<a name='16-customizing-views-1.patch'> </a>

# Customising views

It's pretty surprising how far you can get without even touching the view layer. That's the way we like to work with Hobo - get the models and controllers right and the view will probably get close to what you want. From there you can override just those parts of the view that you need to.

We do that using the DRYML template language which is part of Hobo. DRYML is tag based -- it allows you to define and use your own tags right alongside the regular HTML tags. Tags are like helpers, but a lot more powerful. DRYML is quite unlike other tag-based template languages, thanks to features like the implicit context and nestable parameters. DRYML is also an extension of ERB so you can still use the ERB syntax you're familiar with from Rails.

DRYML is probably the single best part of Hobo. It's very good at high-level re-use because it allows you to make very focussed changes if a given piece of pre-packaged HTML is not *quite* what you want.

A full coverage of DRYML is well beyond the scope of this tutorial. Instead we're going to take a few specific examples of changes we'd like to make to Agility, and see how they're done.



## Add assigned users to the tasks

At the moment, the only way to see who's assigned to a task is to click the task's edit link. Not good. Let's add a list of the assigned users to each task when we're looking at a story.

DRYML has a feature called *polymorphic tags*. These are tags that are defined differently for different types of object. Rapid makes use of this feature with a system of "cards". The tasks that are displayed on the story page are rendered by the `<card>`. You can define custom cards for particular models. Furthermore, if you call `<base-card>` you can define your card by tweaking the default, rather than starting from scratch. This is what DRYML is all about. It's like a smart-bomb, capable of taking out little bits of unwanted HTML with pin-point strikes and no collateral damage.

The file `app/views/taglibs/front_site.dryml` is a place to put tag definitions that will be available throughout the site. Add this definition to that file:

    ::: app/views/taglibs/front_site.dryml
    @@ -13,5 +13,15 @@
     <include src="taglibs/auto/rapid/cards"/>
     <include src="taglibs/auto/rapid/pages"/>
     <include src="taglibs/auto/rapid/forms"/>
     
     <include src="application"/>
    +
    +<extend tag="card" for="Task">
    +  <old-card merge>
    +    <append-body:>
    +    <div class="users">
    +      Assigned users: <repeat:users join=", "><a/></repeat><else>None</else>
    +    </div>
    +    </append-body:>
    +  </old-card>
    +</extend>
    
{: .diff}


OK there's a lot of new concepts thrown at you at once there :-)

First off, refresh the story page. You'll see that in the cards for each task there is now a list of assigned users. The users are clickable - they link to each users home page (which doesn't have much on it at the moment).

The `<extend>` tag is used to extend any tag that's already defined. The body of `<extend>` is our new definition. It's very common to want to base the new definition on the old one, for example, we often want to insert a bit of extra content as we've done here. We can do that by calling the "old" definition, which is available as `<old-card>`. We've passed the `<append-body:>` parameter to `<old-card>` which, in a startling twist, is used to append content to the body of the card. Some points to note:

 * The `<repeat>` tag provides a `join` attribute which we use to insert the commas
 * The link is created with a simple empty `<a/>`. It links to the 'current context' which, in this case, is the user.
 * The `:users` in `<repeat:users>` switches the context. It selects the `users` association of the task.
 * DRYML has a multi-purpose `<else>` tag. When used with repeat, it provides a default for the case when the collection is empty.


gitorial-015: [view on github](http://github.com/Hobo/agility-gitorial/commit/b9a1fca1b6fe73ea8583ca42ba222b105d09915d), [download patch](http://github.com/Hobo/agility-gitorial/commit/b9a1fca1b6fe73ea8583ca42ba222b105d09915d.patch)
{: .commit}




<a name='add-task-summary-to-user-page'> </a>

## Add a task summary to the user's home page

Now that each task provides links to the assigned users, the user's page is not looking great. Rapid has rendered cards for the task-assignments but there's no meaningful content in them. What we'd like to see there is a list of all the tasks the user has been assigned to. Having them grouped by story would be helpful too.

To achieve this we want to create a custom template for `users/show`. If you look in `app/views/users` you'll see that it's empty. When a page template is missing, Hobo tries to fall back on a defined tag. For a 'show' page, that tag is `<show-page>`. The Rapid library provides a definition of `<show-page>`, so that's what we're seeing at the moment. As soon as we create `app/views/users/show.dryml`, that file will take over from the generic `<show-page>` tag. Try creating that file and just throw "Hello!" in there for now. You should see that the user's show page now displays just "Hello!" and has lost all of the page styling.

If you now edit `show.dryml` to read "`<show-page/>`" you'll see we're back where we started. The `<show-page>` tag is just being called explicitly instead of by convention. Rapid has generated a custom definition of `<show-page for="User">`. You can find this in `app/views/taglibs/auto/rapid/pages.dryml`. Don't edit this file! Your changes will be overwritten. Instead use this file as a reference so you can see what the page provides, and what parameters there are (the `param` attributes). You'll see:

    <section param="content-body">
{: .dryml}

That means you can change that part of the page entirely, like this:

	<show-page>
	  <content-body:>Hello!</content-body:>
	</show-page>
{: .dryml}

Edit show.dryml to look like that. The "Hello!" message is back, but now it's embedded in the properly marked-up page.

Now let's get the content we're after - the user's assigned tasks, grouped by story. It's only five lines of markup:

    ::: app/views/users/show.dryml
    @@ -0,0 +1,9 @@
    +<show-page>
    +  <content-body:>
    +    <h3><Your/> Assigned Tasks</h3>
    +    <repeat with="&@user.tasks.group_by(&:story)">
    +      <h4>Story: <a with="&this_key"/></h4>
    +      <collection/>
    +    </repeat>
    +  </content-body:>
    +</show-page>
    
{: .diff}


Again - lots of new stuff there. Let's quickly run over what's going on

 * The `<Your>` tag is a handy little gadget. It outputs "Your" if the context is the current user, otherwise it outputs the user's name. You'll see "Your Assigned Tasks" when looking at yourself, and "Fred's Assigned Tasks" when looking at Fred.

 * We're using `<repeat>` again, but this time we're setting the context to the result of a Ruby expression (`with="&...expr..."`). The expression `@user.tasks.group_by(&:story)` gives us the grouped tasks.

 * We're repeating on a hash this time. Inside the repeat `this` (the implicit context) will be an array of tasks, and `this_key` will be the story. So `<a with="&this_key">` gives us a link to the story.

 * `<collection>` is used to render a collection of anything in a `<ul>` list. By default it renders `<card>` tags. To change this just provide a body to the `<collection>` tag.

That's probably a lot to take in all at once -- the main idea here is to throw you in and give you an overview of what's possible. The [DRYML Guide][] will shed more light.

[DRYML Guide]: http://hobocentral.net/manual/dryml-guide


gitorial-016: [view on github](http://github.com/Hobo/agility-gitorial/commit/2b53abf2736679ad219cc116252fa87d7dac7580), [download patch](http://github.com/Hobo/agility-gitorial/commit/2b53abf2736679ad219cc116252fa87d7dac7580.patch)
{: .commit}




<a name='searchable-sortable-table'> </a>

## Improve the project page with a searchable, sortable table

The project page is currently workable, but we can easily improve it a lot. Rapid provides a tag `<table-plus>` which renders a table with support for sorting by clicking on the headings, and a built-in search bar for filtering the rows displayed. Searching and sorting are done server-side so we need to modify the controller as well as the view for this enhancement.

As with the user's show-page, to get started put a simple call to `<show-page/>` in `app/views/projects/show.dryml`

To see what this page is doing, take a look at `<def tag="show-page" for="Project">` in `pages.dryml` (in `app/views/taglibs/auto/rapid`). Notice this tag:

    <collection:stories param/>
{: .dryml}


That's the part we want to replace with the table. Note that when a `param` attribute doesn't give a name, the name defaults to the same name as the tag. Here's how we would replace that `<collection>` with a simple list of links:

	<show-page>
	  <collection: replace>
	    <div>
	      <repeat:stories join=", "><a/></repeat>
	    </div>
	  </collection:>
	</show-page>
{: .dryml}

You should now see that in place of the story cards, we now get a simple comma-separated list of links to the stories. Not what we want of course, but it illustrates the concept of replacing a parameter.

Here's how we get the table-plus:

    ::: app/views/projects/show.dryml
    @@ -0,0 +1,7 @@
    +<show-page>
    +  <collection: replace>
    +  <table-plus:stories fields="this, status">
    +    <empty-message:>No stories match your criteria</empty-message:>
    +  </table-plus>
    +  </collection:>
    +</show-page>
    
{: .diff}


The `fields` attribute to `<table-plus>` lets you specify a list of fields that will become the columns in the table. We could have said `fields="title, status"` which would have given us the same content in the table, but by saying `this`, the first column contains links to the stories, rather than just the title as text.


gitorial-017: [view on github](http://github.com/Hobo/agility-gitorial/commit/86ea95b9bec5accd182f4d0e730bf40181b92a5f), [download patch](http://github.com/Hobo/agility-gitorial/commit/86ea95b9bec5accd182f4d0e730bf40181b92a5f.patch)
{: .commit}




<a name='stories-table-add-count'> </a>

We could also add a column showing the number of tasks in a story. Change to `fields="this, tasks.count, status"` and see that a column is added with a readable title "Tasks Count".


gitorial-018: [view on github](http://github.com/Hobo/agility-gitorial/commit/aa4385740b72ac9ee5c0d9d8c0896732cde34dbc), [download patch](http://github.com/Hobo/agility-gitorial/commit/aa4385740b72ac9ee5c0d9d8c0896732cde34dbc.patch)
{: .commit}




<a name='stories-table-add-search'> </a>

To get the search feature working, we need to update the controller side. Add a `show` method to `app/controllers/projects_controller.rb` and update the `<table-plus>` to use `@stories` as it's context:

    ::: app/controllers/projects_controller.rb
    @@ -2,6 +2,14 @@
     
       hobo_model_controller
     
       auto_actions :all
     
    +  def show
    +    @project = find_instance
    +    @stories = @project.stories.
    +      search(params[:search], :title).
    +      order_by(parse_sort_param(:title, :status))
    +    hobo_show
    +  end
    +
     end
    ::: app/views/projects/show.dryml
    @@ -1,7 +1,7 @@
     <show-page>
       <collection: replace>
    -  <table-plus:stories fields="this, tasks_count, status">
    +  <table-plus with="&@stories" fields="this, tasks_count, status">
         <empty-message:>No stories match your criteria</empty-message:>
       </table-plus>
       </collection:>
     </show-page>
    
{: .diff}


There's a lot happening here, so we're just going to point you to appropriate manual chapters to explain the concepts.

- [DRYML context switching](/manual/dryml-guide#the_implicit_context)
- [Changing controller action behaviour](/manual/controllers#changing_action_behaviour)
- [search and order_by scopes](/manual/scopes#static_scopes)
- [find_instance](/manual/controller#find_instance)
- [parse_sort_param](/manual/controller#parse_sort_param)


gitorial-019: [view on github](http://github.com/Hobo/agility-gitorial/commit/79f9eb3b24870e01c02e4117a0def80cd0925c9a), [download patch](http://github.com/Hobo/agility-gitorial/commit/79f9eb3b24870e01c02e4117a0def80cd0925c9a.patch)
{: .commit}




<a name='setup-smtp'> </a>

# Setup SMTP

If your web server has Postfix or Sendmail set up to deliver email
without requiring a password, rails should now be delivering email
upon activation.  However, most servers will require some email setup,
so we'll put in a commented block that you can uncomment and adjust if
you have a mail server available:

    ::: config/initializers/smtp.rb
    @@ -0,0 +1,9 @@
    +#ActionMailer::Base.delivery_method = :smtp
    +#ActionMailer::Base.smtp_settings = {
    +#   :address => "smtp.example.com",
    +#   :port => 25,
    +#   :domain => "example.com",
    +#   :authentication => :login,
    +#   :user_name => "username",
    +#   :password => "password",
    +#}
    
{: .diff}



gitorial-020: [view on github](http://github.com/Hobo/agility-gitorial/commit/449286066d516e700c5b759abd54d209966c7f99), [download patch](http://github.com/Hobo/agility-gitorial/commit/449286066d516e700c5b759abd54d209966c7f99.patch)
{: .commit}




<a name='add-flash-message'> </a>

The default state for a user is now "inactive".  So when users sign up,
they are no longer automatically logged in.  Let's set a flash message
so they don't get confused

    ::: app/controllers/users_controller.rb
    @@ -15,6 +15,14 @@
             redirect_to home_page
           end
         end
       end
     
    +  def do_signup
    +    hobo_do_signup do
    +      if this.errors.blank?
    +        flash[:notice] << "You must activate your account before you can log in.  Please check your email."
    +      end
    +    end
    +  end
    +
     end
    
{: .diff}



gitorial-021: [view on github](http://github.com/Hobo/agility-gitorial/commit/001bea6151536c939e2833fabba8310ed43ff626), [download patch](http://github.com/Hobo/agility-gitorial/commit/001bea6151536c939e2833fabba8310ed43ff626.patch)
{: .commit}




<a name='display-activation-link'> </a>

Approximately 99% of you following this tutorial will not have set up
email correctly.  So how do you sign up?   One option is to cut and
paste out of your log files.   However, we'll be doing some
integration testing later, so we do need something a little more
convenient.  Just make sure that you revert this change before you go
to production!

    ::: app/controllers/users_controller.rb
    @@ -19,10 +19,15 @@
     
       def do_signup
         hobo_do_signup do
           if this.errors.blank?
             flash[:notice] << "You must activate your account before you can log in.  Please check your email."
    +        
    +        # FIXME: remove these two lines after you get email working reliably
    +        # and before your application leaves its sandbox...
    +        secret_path = user_activate_path :id=>this.id, :key => this.lifecycle.key
    +        flash[:notice] = "Thanks for signing up!  The 'secret' link that was just emailed was: <a id='activation-link' href='#{secret_path}'>#{secret_path}</a>.".html_safe
           end
         end
       end
     
     end
    
{: .diff}



gitorial-022: [view on github](http://github.com/Hobo/agility-gitorial/commit/c7731308af1adb7fed02300448117439ff3e446f), [download patch](http://github.com/Hobo/agility-gitorial/commit/c7731308af1adb7fed02300448117439ff3e446f.patch)
{: .commit}




<a name='25-odds-and-ends.patch'> </a>

# Odds and ends

We're now going to work through some more easy but very valuable enhancements to the app. We're going to add:

 * A menu for story statuses. The free-form text field is a bit poor after all. We'll do this first with a hard-wired set of options, and then add the ability to manage the set of available statuses.

 * Add filtering of stories by status to the project page

 * Drag and drop re-ordering of tasks. This effectively gives us prioritisation of tasks.

 * Markdown or textile formatting of stories. This is implemented by changing *one symbol* in the source code.

Off we go.



## Story status menu

We're going to do this in two stages - first a fixed menu that would require a source-code change if you ever need to alter the available statuses. We'll then remove that restriction by adding a StoryStatus model. We'll also see the migration generator in action again.

The fixed menu is brain-dead simple. Track down the declaration of the status field in `story.rb` (it's in the `fields do ... end` block), and change it to read something like:

    ::: app/models/story.rb
    @@ -3,11 +3,11 @@
       hobo_model # Don't put anything above this
     
       fields do
         title  :string
         body   :text
    -    status :string
    +    status enum_string(:new, :accepted, :discussion, :implementation)
         tasks_count :integer, :default => 0, :null => false
         timestamps
       end
       attr_accessible :title, :body, :status, :project, :project_id, :tasks
     
    
{: .diff}


Job done. If you want the gory details, `enum_string` is a *type constructor*. It creates an anonymous class that represents this enumerated type (a subclass of String). You can see this in action by trying this in the console:

	>> Story.find(:first).status.class
{: .ruby}


gitorial-023: [view on github](http://github.com/Hobo/agility-gitorial/commit/1556a4bfeb1682799303f500eeac8e95969b387f), [download patch](http://github.com/Hobo/agility-gitorial/commit/1556a4bfeb1682799303f500eeac8e95969b387f.patch)
{: .commit}




<a name='story-status-ajaxified'> </a>

Now there is a status selector on the 'story/edit' page. It would be nice though if we had an ajaxified editor right on the story 'show' page. Edit `app/views/stories/show.dryml` to be:

    ::: app/views/stories/show.dryml
    @@ -0,0 +1,3 @@
    +<show-page>
    +  <field-list: tag="editor"/>
    +</show-page>
    
{: .diff}


What did that do? `<show-page>` uses a tag `<field-list>` to render a table of fields. DRYML's parameter mechanism allows the caller to customize the parameters that are passed to `<field-list>`. On our story page the field-list contains only the status field. By default `<field-list>` uses the `<view>` tag to render read-only views of the fields, but that can be changed by passing a tag name to the `tag` attribute. We're passing `editor` which is a tag for creating ajax-style in-place editors.


gitorial-024: [view on github](http://github.com/Hobo/agility-gitorial/commit/056b26cb2a6baac7fb08c6eb1b768dc68afb4d38), [download patch](http://github.com/Hobo/agility-gitorial/commit/056b26cb2a6baac7fb08c6eb1b768dc68afb4d38.patch)
{: .commit}




<a name='generate-story-status-model'> </a>

## Have a configurable set of statuses

In order to support management of the statuses available, we'll create a StoryStatus model

	$ hobo generate resource story_status name:string


gitorial-025: [view on github](http://github.com/Hobo/agility-gitorial/commit/1c635c7d50a15cb7ae95df7c5a636605e7daa080), [download patch](http://github.com/Hobo/agility-gitorial/commit/1c635c7d50a15cb7ae95df7c5a636605e7daa080.patch)
{: .commit}




<a name='auto-actions-story-status-controller'> </a>

Whenever you create a new model + controller with Hobo, get into the habit of thinking about permissions and controller actions. In this case, we probably want only admins to be able to manage the permissions. As for actions, we probably only want the write actions, and the index page:

    ::: app/controllers/story_statuses_controller.rb
    @@ -1,7 +1,7 @@
     class StoryStatusesController < ApplicationController
     
       hobo_model_controller
     
    -  auto_actions :all
    +  auto_actions :write_only, :new, :index
     
     end
    
{: .diff}



gitorial-026: [view on github](http://github.com/Hobo/agility-gitorial/commit/fd40913dc75cf4d6a12613342b364e8562374eaf), [download patch](http://github.com/Hobo/agility-gitorial/commit/fd40913dc75cf4d6a12613342b364e8562374eaf.patch)
{: .commit}




<a name='story-status-belongs-to-story'> </a>

Next, remove the 'status' field from the `fields do ... end` block in the Story model. Then add an association with the StoryStatus model:

    ::: app/models/story.rb
    @@ -3,17 +3,17 @@
       hobo_model # Don't put anything above this
     
       fields do
         title  :string
         body   :text
    -    status enum_string(:new, :accepted, :discussion, :implementation)
         tasks_count :integer, :default => 0, :null => false
         timestamps
       end
       attr_accessible :title, :body, :status, :project, :project_id, :tasks
     
       belongs_to :project, :inverse_of => :stories, :counter_cache => true
    +  belongs_to :status, :class_name => "StoryStatus", :inverse_of => :stories
     
       has_many :tasks, :dependent => :destroy, :inverse_of => :story
     
       children :tasks
     
    ::: app/models/story_status.rb
    @@ -6,10 +6,12 @@
         name :string
         timestamps
       end
       attr_accessible :name
     
    +  has_many :stories, :inverse_of => :status
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    
{: .diff}



gitorial-027: [view on github](http://github.com/Hobo/agility-gitorial/commit/6d12e2a53f3c067484fdd0bd00945d56ffff7626), [download patch](http://github.com/Hobo/agility-gitorial/commit/6d12e2a53f3c067484fdd0bd00945d56ffff7626.patch)
{: .commit}




<a name='story-status-model-migration'> </a>

Now run the migration generator

    $ hobo generate migration

You'll see that the migration generator considers this change to be ambiguous. Whenever there are columns removed *and* columns added, the migration generator can't tell whether you're actually removing one column and adding another, or if you are renaming the old column. It's also pretty fussy about what it makes you type. We really don't want to play fast and lose with your precious data, so to confirm that you want to drop the 'status' column, you have to type in full: "drop status".

Once you've done that you'll see that the generated migration includes the creation of the new foreign key and the removal of the old status column.  Press `g` now to generate the migration without running it.


gitorial-028: [view on github](http://github.com/Hobo/agility-gitorial/commit/b5316c877661c165bea876bd3b4711a5aaddf9f7), [download patch](http://github.com/Hobo/agility-gitorial/commit/b5316c877661c165bea876bd3b4711a5aaddf9f7.patch)
{: .commit}




<a name='story-status-model-migration-edit'> </a>

You can always edit the migration before running it. For example you could create some initial story statuses by adding this code to the `self.up` method:

    ::: db/migrate/20130109022053_add_story_status_model.rb
    @@ -8,10 +8,13 @@
     
         add_column :stories, :status_id, :integer
         remove_column :stories, :status
     
         add_index :stories, [:status_id]
    +
    +    statuses = %w(new accepted discussion implementation user_testing deployed rejected)
    +    statuses.each { |status| StoryStatus.create :name => status }
       end
     
       def self.down
         remove_column :stories, :status_id
         add_column :stories, :status, :string
    
{: .diff}



gitorial-029: [view on github](http://github.com/Hobo/agility-gitorial/commit/f4a59e370c65bb336711b250371fb9230c1bd174), [download patch](http://github.com/Hobo/agility-gitorial/commit/f4a59e370c65bb336711b250371fb9230c1bd174.patch)
{: .commit}




<a name='story-status-model-migration-run'> </a>

Run your modified migration:

    $ rake db:migrate

That's it. The page to manage the story statuses should appear in the main navigation.

Now that we've got more structured statuses, let's do something with them...


gitorial-030: [view on github](http://github.com/Hobo/agility-gitorial/commit/4c8a749af9f304950d7c5018f2f39df52421f963), [download patch](http://github.com/Hobo/agility-gitorial/commit/4c8a749af9f304950d7c5018f2f39df52421f963.patch)
{: .commit}




<a name='filtering-stories-by-status-dryml'> </a>

## Filtering stories by status

Rapid's `<table-plus>` is giving us some nice searching and sorting features on the project page. We can easily add some filtering into the mix, so that it's easy to, say, see only new stories.

First we'll add the filter control to the header of the table-plus. Rapid provides a `<filter-menu>` tag which is just what we need. We want to add it to the header section, before the stuff that's already there. In DRYML, you can prepend or append content to any named parameter. `<table-plus>` has a `header:` parameter, so we can use `<prepend-header:>`, like this:

    ::: app/views/projects/show.dryml
    @@ -1,7 +1,12 @@
     <show-page>
       <collection: replace>
       <table-plus with="&@stories" fields="this, tasks_count, status">
    +    <prepend-header:>
    +      <div class="filter">
    +        Display by status: <filter-menu param-name="status" options="&StoryStatus.all"/>
    +      </div>
    +    </prepend-header:>
         <empty-message:>No stories match your criteria</empty-message:>
       </table-plus>
       </collection:>
     </show-page>
    
{: .diff}



gitorial-031: [view on github](http://github.com/Hobo/agility-gitorial/commit/4b195231c1121bd2b2a08f9bfa4aaccd0bb362a1), [download patch](http://github.com/Hobo/agility-gitorial/commit/4b195231c1121bd2b2a08f9bfa4aaccd0bb362a1.patch)
{: .commit}




<a name='filtering-stories-by-status-css'> </a>

To make the filter look right, create a file `app/assets/stylesheets/front/agility-custom-styles.css`

    ::: app/assets/stylesheets/front/agility-custom-styles.css
    @@ -0,0 +1,3 @@
    +.show-page.project .filter {float: left;}
    +.show-page.project .filter form, .show-page.project .filter form div {display: inline;}
    +
    
{: .diff}



gitorial-032: [view on github](http://github.com/Hobo/agility-gitorial/commit/2251b2b6bb26389c30c096c289fd0c50c8e57dd6), [download patch](http://github.com/Hobo/agility-gitorial/commit/2251b2b6bb26389c30c096c289fd0c50c8e57dd6.patch)
{: .commit}




<a name='filtering-stories-by-status-controller'> </a>

If you try to use the filter widget, you'll see it adds a `status` parameter in the query string. We need to pick that up and do something useful with it in the Projects controller at `app/controllers/projects_controller.rb`.  To do so, we will use an [association scope](/manual/scopes#association_scopes).

    ::: app/controllers/projects_controller.rb
    @@ -7,9 +7,10 @@
       def show
         @project = find_instance
         @stories = @project.stories.
           search(params[:search], :title).
           order_by(parse_sort_param(:title, :status))
    +    @stories = @stories.status_is(params[:status]) if params[:status] && !params[:status].blank?
         hobo_show
       end
     
     end
    
{: .diff}


Status filtering should now be working.


gitorial-033: [view on github](http://github.com/Hobo/agility-gitorial/commit/7679769e18dc64d2ae080b348a5c4eb9f44c5c34), [download patch](http://github.com/Hobo/agility-gitorial/commit/7679769e18dc64d2ae080b348a5c4eb9f44c5c34.patch)
{: .commit}




<a name='install-acts-as-list'> </a>

# Task re-ordering

We're now going to add the ability to re-order a story's tasks by
drag-and-drop. There's support for this built into Hobo, so there's
not much to do. First we need the `acts_as_list` plugin.  Add

    gem "acts_as_list"

to Gemfile and run

    $ bundle


gitorial-034: [view on github](http://github.com/Hobo/agility-gitorial/commit/705e5799ba025d751f51ffac0ec91c6b110a75e3), [download patch](http://github.com/Hobo/agility-gitorial/commit/705e5799ba025d751f51ffac0ec91c6b110a75e3.patch)
{: .commit}




<a name='acts-as-list-model-changes'> </a>

Now two changes to our models:

    ::: app/models/story.rb
    @@ -10,12 +10,11 @@
       end
       attr_accessible :title, :body, :status, :project, :project_id, :tasks
     
       belongs_to :project, :inverse_of => :stories, :counter_cache => true
       belongs_to :status, :class_name => "StoryStatus", :inverse_of => :stories
    -
    -  has_many :tasks, :dependent => :destroy, :inverse_of => :story
    +  has_many :tasks, :dependent => :destroy, :inverse_of => :story, :order => :position
     
       children :tasks
     
       # --- Permissions --- #
     
    ::: app/models/task.rb
    @@ -11,10 +11,12 @@
       belongs_to :story, :inverse_of => :tasks, :counter_cache => true
     
       has_many :task_assignments, :dependent => :destroy, :inverse_of => :task
       has_many :users, :through => :task_assignments, :accessible => true, :dependent => :destroy
     
    +  acts_as_list :scope => :story
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    
{: .diff}



gitorial-035: [view on github](http://github.com/Hobo/agility-gitorial/commit/0e8f418eca26ca2551074189d5107f4b60ac438c), [download patch](http://github.com/Hobo/agility-gitorial/commit/0e8f418eca26ca2551074189d5107f4b60ac438c.patch)
{: .commit}




<a name='acts-as-list-migrate'> </a>

The migration generator knows about `acts_as_list`, so you can just
run it and you'll get the new position column on Task.

    $ hobo generate migration

And that's it!


gitorial-036: [view on github](http://github.com/Hobo/agility-gitorial/commit/55d69115ceec3550cb626fcc67ef9e5941a9b9a6), [download patch](http://github.com/Hobo/agility-gitorial/commit/55d69115ceec3550cb626fcc67ef9e5941a9b9a6.patch)
{: .commit}




<a name='remove-position-from-task-form'> </a>

You'll notice a slight glitch -- the tasks position has been added to the new-task and edit-task forms. We don't want that. We'll fix it by customising the Task form.

In `application.dryml` add:

    ::: app/views/taglibs/front_site.dryml
    @@ -23,5 +23,11 @@
           Assigned users: <repeat:users join=", "><a/></repeat><else>None</else>
         </div>
         </append-body:>
       </old-card>
     </extend>
    +
    +<extend tag="form" for="Task">
    +  <old-form merge>
    +    <field-list: fields="description, users"/>
    +  </old-form>
    +</extend>
    
{: .diff}



gitorial-037: [view on github](http://github.com/Hobo/agility-gitorial/commit/f7698b8063bf46cc98c5ba3cb337ea652d30958f), [download patch](http://github.com/Hobo/agility-gitorial/commit/f7698b8063bf46cc98c5ba3cb337ea652d30958f.patch)
{: .commit}




<a name='fix-task-form-cancel'> </a>

On the task edit page you might also have noticed that Rapid didn't manage to figure out a destination for the cancel link. You can fix that by editing `tasks/edit.dryml` to be:

    ::: app/views/tasks/edit.dryml
    @@ -0,0 +1,5 @@
    +<edit-page>
    +  <form:>
    +    <cancel: with="&this.story"/>
    +  </form:>
    +</edit-page>
    
{: .diff}


This is a good demonstration of DRYML's nested parameter feature. The `<edit-page>` makes it's form available as a parameter, and the form provides a `<cancel:>` parameter. We can drill down from the edit-page to the form and then to the cancel link to pass in a custom attribute. You can do this to any depth.


gitorial-038: [view on github](http://github.com/Hobo/agility-gitorial/commit/41dc507950b801f1e2b2e4cd748aa0a8ab6a75ec), [download patch](http://github.com/Hobo/agility-gitorial/commit/41dc507950b801f1e2b2e4cd748aa0a8ab6a75ec.patch)
{: .commit}




<a name='markdown-formatting-of-stories'> </a>

# Markdown / Textile formatting of stories

We'll wrap up this section with a really easy one. Hobo renders model fields based on their type. You can add your own custom types and there's a bunch built-in, including textile and markdown formatted strings.

Location the `fields do ... end` section in the Story model, and change

    ::: app/models/story.rb
    @@ -2,11 +2,11 @@
     
       hobo_model # Don't put anything above this
     
       fields do
         title  :string
    -    body   :text
    +    body   :markdown # or :textile
         tasks_count :integer, :default => 0, :null => false
         timestamps
       end
       attr_accessible :title, :body, :status, :project, :project_id, :tasks
     
    
{: .diff}



gitorial-039: [view on github](http://github.com/Hobo/agility-gitorial/commit/a8c875fc2d757a6c11529c09aaac98157e1b32bf), [download patch](http://github.com/Hobo/agility-gitorial/commit/a8c875fc2d757a6c11529c09aaac98157e1b32bf.patch)
{: .commit}




<a name='add-bluecloth-gem'> </a>

You may need to install the relevant ruby gem: either BlueCloth
(markdown) or RedCloth (textile).   Do this by adding

    gem "bluecloth"

to your Gemfile and then running


    $ bundle install


gitorial-040: [view on github](http://github.com/Hobo/agility-gitorial/commit/79c070892cd3cd92f2375b48b5139aa6cadf582f), [download patch](http://github.com/Hobo/agility-gitorial/commit/79c070892cd3cd92f2375b48b5139aa6cadf582f.patch)
{: .commit}




<a name='project-belongs-to-user'> </a>

# Project ownership

The next goal for Agility is to move to a full multi-user application, where users can create their own projects and control who has access to them. Rather than make this change in one go, we'll start with a small change that doesn't do much by itself, but is a step in the right direction: making projects be owned by users.

Add the following to the Project model:

    ::: app/models/project.rb
    @@ -11,10 +11,12 @@
     
       has_many :stories, :dependent => :destroy, :inverse_of => :project
     
       children :stories
     
    +  belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :projects
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    
{: .diff}


There's a Hobo extension there: `:creator => true` tells Hobo that when creating one of these things, the `owner` association should be automatically set up to be the user doing the create.


gitorial-041: [view on github](http://github.com/Hobo/agility-gitorial/commit/d91f496da7158b944f3e4c99568d9465298a0b6d), [download patch](http://github.com/Hobo/agility-gitorial/commit/d91f496da7158b944f3e4c99568d9465298a0b6d.patch)
{: .commit}




<a name='users-have-many-projects'> </a>

We also need the other end of this association, in the User model:

    ::: app/models/user.rb
    @@ -12,10 +12,11 @@
     
       validates_presence_of :name
     
       has_many :task_assignments, :dependent => :destroy, :inverse_of => :user
       has_many :tasks, :through => :task_assignments
    +  has_many :projects, :class_name => "Project", :foreign_key => "owner_id", :inverse_of => :owner
     
       # This gives admin rights and an :active state to the first sign-up.
       # Just remove it if you don't want that
       before_create do |user|
         if !Rails.env.test? && user.class.count == 0
    
{: .diff}



gitorial-042: [view on github](http://github.com/Hobo/agility-gitorial/commit/b6ef7606ad8646633ac1bc213611cbc0e5bfbd6e), [download patch](http://github.com/Hobo/agility-gitorial/commit/b6ef7606ad8646633ac1bc213611cbc0e5bfbd6e.patch)
{: .commit}




<a name='project-permissions'> </a>

How should this affect the permissions? Certain operations on the project should probably be restricted to its owner. We'll use the `owner_is?` helper (that Hobo provides for every `belongs_to` relationship) as it can save an extra database hit. So, edit these permission methods in the Project model:

    ::: app/models/project.rb
    @@ -16,19 +16,19 @@
       belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :projects
     
       # --- Permissions --- #
     
       def create_permitted?
    -    acting_user.administrator?
    +    owner_is? acting_user
       end
     
       def update_permitted?
    -    acting_user.administrator?
    +    acting_user.administrator? || (owner_is?(acting_user) && !owner_changed?)
       end
     
       def destroy_permitted?
    -    acting_user.administrator?
    +    acting_user.administrator? || owner_is?(acting_user)
       end
     
       def view_permitted?(field)
         true
       end
    
{: .diff}


Note that in the `create_permitted?` method, we assert that `owner_is? acting_user`. This is very often found in conjunction with `:creator => true`. Together, these mean that the current user can create their own projects only, and the "Owner" form field will be automatically removed from the new project form.


gitorial-043: [view on github](http://github.com/Hobo/agility-gitorial/commit/8debfa8c1b5b76f09d87d43818fa1fd79023455b), [download patch](http://github.com/Hobo/agility-gitorial/commit/8debfa8c1b5b76f09d87d43818fa1fd79023455b.patch)
{: .commit}




<a name='task-assignment-permissions'> </a>

The stories, tasks and task assignments associated with the project
need permissions similar to that of their containing project.  Let's
set their permission to check their containing project:

    ::: app/models/story.rb
    @@ -17,19 +17,19 @@
       children :tasks
     
       # --- Permissions --- #
     
       def create_permitted?
    -    acting_user.administrator?
    +    project.creatable_by?(acting_user)
       end
     
       def update_permitted?
    -    acting_user.signed_up? && !project_changed?
    +    project.updatable_by?(acting_user)
       end
     
       def destroy_permitted?
    -    acting_user.administrator?
    +    project.destroyable_by?(acting_user)
       end
     
       def view_permitted?(field)
         true
       end
    ::: app/models/task.rb
    @@ -16,19 +16,19 @@
       acts_as_list :scope => :story
     
       # --- Permissions --- #
     
       def create_permitted?
    -    acting_user.administrator?
    +    story.creatable_by?(acting_user)
       end
     
       def update_permitted?
    -    acting_user.signed_up? && !story_changed?
    +    story.updatable_by?(acting_user)
       end
     
       def destroy_permitted?
    -    acting_user.administrator?
    +    story.destroyable_by?(acting_user)
       end
     
       def view_permitted?(field)
         true
       end
    ::: app/models/task_assignment.rb
    @@ -11,21 +11,21 @@
       belongs_to :task, :inverse_of => :task_assignments
     
       # --- Permissions --- #
     
       def create_permitted?
    -    acting_user.administrator?
    +    task.creatable_by?(acting_user)
       end
     
       def update_permitted?
    -    acting_user.administrator?
    +    task.updatable_by?(acting_user)
       end
     
       def destroy_permitted?
    -    acting_user.administrator?
    +    task.destroyable_by?(acting_user)
       end
     
       def view_permitted?(field)
    -    true
    +    task.viewable_by?(acting_user)
       end
     
     end
    
{: .diff}



gitorial-044: [view on github](http://github.com/Hobo/agility-gitorial/commit/ed840ec839c6bf9e8b425a8abbd7e759b3b445b3), [download patch](http://github.com/Hobo/agility-gitorial/commit/ed840ec839c6bf9e8b425a8abbd7e759b3b445b3.patch)
{: .commit}




<a name='project-ownership-migration'> </a>

Run the migration generator to see the effect on the app:

    $ hobo generate migration


gitorial-045: [view on github](http://github.com/Hobo/agility-gitorial/commit/7b6474f8fa253162f82cc37ba3c55548bbe4222f), [download patch](http://github.com/Hobo/agility-gitorial/commit/7b6474f8fa253162f82cc37ba3c55548bbe4222f.patch)
{: .commit}




<a name='add-your-projects-to-front'> </a>

Finally, let's add a handy list of "Your Projects" to the home page. Edit the content-body section of `app/views/front/index.dryml` to be:

    ::: app/views/front/index.dryml
    @@ -21,10 +21,12 @@
     
     
           </section>
         </header>
     
    -    <section class="content-body">
    +    <section class="content-body" if="&logged_in?">
    +      <h3>Your Projects</h3>
    +      <collection:projects with="&current_user"/>
         </section>
       </content:>
     
     </page>
    
{: .diff}



gitorial-046: [view on github](http://github.com/Hobo/agility-gitorial/commit/2668296acd43fda5a90a0d5f3c1aebe03be53850), [download patch](http://github.com/Hobo/agility-gitorial/commit/2668296acd43fda5a90a0d5f3c1aebe03be53850.patch)
{: .commit}




<a name='project-cards-without-creator-link'> </a>

One thing you'll notice is that the project cards have a link to the project owner. In general that's quite useful, but in this context it doesn't make much sense. DRYML is very good at favouring context over consistency -- we can remove that link very easily:

    ::: app/views/front/index.dryml
    @@ -23,10 +23,10 @@
           </section>
         </header>
     
         <section class="content-body" if="&logged_in?">
           <h3>Your Projects</h3>
    -      <collection:projects with="&current_user"/>
    +      <collection:projects with="&current_user"><card without-creator-link/></collection>
         </section>
       </content:>
     
     </page>
    
{: .diff}



gitorial-047: [view on github](http://github.com/Hobo/agility-gitorial/commit/ee1b876317d13b4e896de9679a89748cafe1a652), [download patch](http://github.com/Hobo/agility-gitorial/commit/ee1b876317d13b4e896de9679a89748cafe1a652.patch)
{: .commit}




<a name='generate-project-membership'> </a>

# Granting read access to others

Now that we've got users owning their own projects, it seems wrong that any signed-up user can view any project. On the other hand it wouldn't make any sense to hide the project from everyone. What we need is a way for the project owner to grant others access.

We can model this with a ProjectMembership model that represents access for a specific user and project:

    $ hobo generate resource project_membership


gitorial-048: [view on github](http://github.com/Hobo/agility-gitorial/commit/c05c0f196d2468220c362b86fe75489c4c974cdd), [download patch](http://github.com/Hobo/agility-gitorial/commit/c05c0f196d2468220c362b86fe75489c4c974cdd.patch)
{: .commit}




<a name='project-memberships-tweak-auto-actions'> </a>

First remove the actions we don't need on the `ProjectMembershipsController`:

    ::: app/controllers/project_memberships_controller.rb
    @@ -1,7 +1,7 @@
     class ProjectMembershipsController < ApplicationController
     
       hobo_model_controller
     
    -  auto_actions :all
    +  auto_actions :write_only
     
     end
    
{: .diff}



gitorial-049: [view on github](http://github.com/Hobo/agility-gitorial/commit/e3722e0feb2ecdcd396ed2fde5df4d08d0bb5da8), [download patch](http://github.com/Hobo/agility-gitorial/commit/e3722e0feb2ecdcd396ed2fde5df4d08d0bb5da8.patch)
{: .commit}




<a name='project-memberships-add-associations-to-model'> </a>

Next, add the associations to the model:

    ::: app/models/project_membership.rb
    @@ -5,10 +5,13 @@
       fields do
         timestamps
       end
       attr_accessible 
     
    +  belongs_to :project, :inverse_of => :memberships
    +  belongs_to :user, :inverse_of => :project_memberships
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    
{: .diff}



gitorial-050: [view on github](http://github.com/Hobo/agility-gitorial/commit/1013ec6bc16a1f70b418d3a29bfc40d7e58bac16), [download patch](http://github.com/Hobo/agility-gitorial/commit/1013ec6bc16a1f70b418d3a29bfc40d7e58bac16.patch)
{: .commit}




<a name='migrate-project-memberships'> </a>

Run the migration generator to have the required foreign keys added to
the database:

    $ hobo g migration


gitorial-051: [view on github](http://github.com/Hobo/agility-gitorial/commit/128efb7e5e750a7a546e03490c66ff6400252c9f), [download patch](http://github.com/Hobo/agility-gitorial/commit/128efb7e5e750a7a546e03490c66ff6400252c9f.patch)
{: .commit}




<a name='project-memberships-permissions'> </a>

Then permissions -- only the project owner (and admins) can manipulate these project memberships:


gitorial-052: [view on github](http://github.com/Hobo/agility-gitorial/commit/4c0c181513eb19c06610963f6d69e50caad14eb0), [download patch](http://github.com/Hobo/agility-gitorial/commit/4c0c181513eb19c06610963f6d69e50caad14eb0.patch)
{: .commit}




<a name='project-has-many-members'> </a>

Let's do the other ends of those two belongs-to associations. In the Project model:

    ::: app/models/project.rb
    @@ -12,10 +12,14 @@
       has_many :stories, :dependent => :destroy, :inverse_of => :project
     
       children :stories
     
       belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :projects
    +  has_many :memberships, :class_name => "ProjectMembership", :dependent => :destroy, :inverse_of => :project
    +  has_many :members, :through => :memberships, :source => :user
    +
    +  belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :projects
     
       # --- Permissions --- #
     
       def create_permitted?
         owner_is? acting_user
    
{: .diff}



gitorial-053: [view on github](http://github.com/Hobo/agility-gitorial/commit/79241d74a221d2fed0daef1db79371f4ca7c4f0f), [download patch](http://github.com/Hobo/agility-gitorial/commit/79241d74a221d2fed0daef1db79371f4ca7c4f0f.patch)
{: .commit}




<a name='user-has-many-joined-projects'> </a>

And in the User model (remember that User already has an association called `projects` so we need a new name):

    ::: app/models/user.rb
    @@ -13,10 +13,12 @@
       validates_presence_of :name
     
       has_many :task_assignments, :dependent => :destroy, :inverse_of => :user
       has_many :tasks, :through => :task_assignments
       has_many :projects, :class_name => "Project", :foreign_key => "owner_id", :inverse_of => :owner
    +  has_many :project_memberships, :dependent => :destroy, :inverse_of => :user
    +  has_many :joined_projects, :through => :project_memberships, :source => :project
     
       # This gives admin rights and an :active state to the first sign-up.
       # Just remove it if you don't want that
       before_create do |user|
         if !Rails.env.test? && user.class.count == 0
    
{: .diff}



gitorial-054: [view on github](http://github.com/Hobo/agility-gitorial/commit/9f94b65ff88fba1d8a804bf4e5bec5fb2e6643dd), [download patch](http://github.com/Hobo/agility-gitorial/commit/9f94b65ff88fba1d8a804bf4e5bec5fb2e6643dd.patch)
{: .commit}




<a name='view-permission-based-on-project-membership'> </a>

Note that users now have two collections of projects: `projects` are the projects that users own, and `joined_projects` are the projects they have joined as members.

We can now define view permission on projects, stories and tasks according to project membership.

    ::: app/models/project.rb
    @@ -32,9 +32,9 @@
       def destroy_permitted?
         acting_user.administrator? || owner_is?(acting_user)
       end
     
       def view_permitted?(field)
    -    true
    +    acting_user.administrator? || acting_user == owner || acting_user.in?(members)
       end
     
     end
    ::: app/models/story.rb
    @@ -29,9 +29,9 @@
       def destroy_permitted?
         project.destroyable_by?(acting_user)
       end
     
       def view_permitted?(field)
    -    true
    +    project.viewable_by?(acting_user)
       end
     
     end
    ::: app/models/task.rb
    @@ -28,9 +28,9 @@
       def destroy_permitted?
         story.destroyable_by?(acting_user)
       end
     
       def view_permitted?(field)
    -    true
    +    story.viewable_by?(acting_user)
       end
     
     end
    
{: .diff}



gitorial-055: [view on github](http://github.com/Hobo/agility-gitorial/commit/688266088b86213f5220d9116500fe7a03ddac8e), [download patch](http://github.com/Hobo/agility-gitorial/commit/688266088b86213f5220d9116500fe7a03ddac8e.patch)
{: .commit}




<a name='update-project-actions'> </a>

Finally, now that not all projects are viewable by all users, the projects index page won't work too well. In addition, the top-level New Project page at `/projects/new` isn't suited to our purposes any more. It will fit better with Hobo's RESTful architecture to create projects for specific users, e.g. at `/users/12/projects/new`

So we'll modify the actions provided by the projects controller to:

    ::: app/controllers/projects_controller.rb
    @@ -1,10 +1,12 @@
     class ProjectsController < ApplicationController
     
       hobo_model_controller
     
    -  auto_actions :all
    +  auto_actions :show, :edit, :update, :destroy
    +
    +  auto_actions_for :owner, [:new, :create]
     
       def show
         @project = find_instance
         @stories = @project.stories.
           search(params[:search], :title).
    
{: .diff}


Note that there won't be a link to that new-project page by default -- we'll add one in the next section.


gitorial-056: [view on github](http://github.com/Hobo/agility-gitorial/commit/01809a6494155b5c19544ff98aa96b88fd94456b), [download patch](http://github.com/Hobo/agility-gitorial/commit/01809a6494155b5c19544ff98aa96b88fd94456b.patch)
{: .commit}




<a name='move-membership-to-sidebar'> </a>

## The view layer

We would like the list of project memberships to appear in a side-bar
on the project show page, so the page will now display two
collections: stories and memberships. We can tell Rapid that these are
the two collections we are interested in using Hobo's view hints.
Edit the project model like this:

    ::: app/models/project.rb
    @@ -9,11 +9,11 @@
       end
       attr_accessible :name, :stories
     
       has_many :stories, :dependent => :destroy, :inverse_of => :project
     
    -  children :stories
    +  children :stories, :memberships
     
       belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :projects
       has_many :memberships, :class_name => "ProjectMembership", :dependent => :destroy, :inverse_of => :project
       has_many :members, :through => :memberships, :source => :user
     
    
{: .diff}


Note that view hints are defined in the model.   This is not a great
place for them, but it is better than the alternatives.

It is very common for websites to present information in a hierarchy, and this `children` declaration tells Hobo about the hierarchy of your data. The order is significant; in this example `stories` is the 'main' child relationship, and `memberships` is secondary. The Rapid page generators use this information and place the `stories` collection in the main area of the page, and an aside section will be added for the `memberships`.

Refresh any project page and you should see the collection, which will be empty of course, in a side-bar.


gitorial-057: [view on github](http://github.com/Hobo/agility-gitorial/commit/30de0910dc9c4aff05bb52c235f37d8964c016a3), [download patch](http://github.com/Hobo/agility-gitorial/commit/30de0910dc9c4aff05bb52c235f37d8964c016a3.patch)
{: .commit}




<a name='auto-completion-controller'> </a>

## A form with auto-completion

Now we'll create the form to add a new person to the project. We'll set it up so that you can type the user's name, with auto-completion, in order to add someone to the project.

First we need the controller side of the auto-complete. Add this declaration to `users_controller.rb`:

    ::: app/controllers/users_controller.rb
    @@ -2,10 +2,12 @@
     
       hobo_user_controller
     
       auto_actions :all, :except => [ :index, :new, :create ]
     
    +  autocomplete
    +
       # Normally, users should be created via the user lifecycle, except
       #  for the initial user created via the form on the front screen on
       #  first run.  This method creates the initial user.
       def create
         hobo_create do
    
{: .diff}



gitorial-058: [view on github](http://github.com/Hobo/agility-gitorial/commit/3d19073ed33c6432e88e18e1974bb77b1e0d823f), [download patch](http://github.com/Hobo/agility-gitorial/commit/3d19073ed33c6432e88e18e1974bb77b1e0d823f.patch)
{: .commit}




<a name='auto-completion-form'> </a>

Now for the form in `projects/show.dryml`. We'll use Hobo's ajax `part` mechanism to refresh the collection without reloading the page:

    ::: app/views/projects/show.dryml
    @@ -7,6 +7,19 @@
           </div>
         </prepend-header:>
         <empty-message:>No stories match your criteria</empty-message:>
       </table-plus>
       </collection:>
    -</show-page>
    +
    +  <aside:>
    +    <h2>Project Members</h2>
    +    <collection:members part="members"/>
    +
    +    <form:memberships.new update="members" reset-form refocus-form>
    +      <div>
    +        Add a member:
    +        <name-one:user/>
    +      </div>
    +    </form>
    +  </aside:>
    +
    +</show-page>
    
{: .diff}


Some things to note:

 - The `<collection>` tag has `part="members"`. This creates a re-loadable section of the page, much as you would achieve with partials in regular Rails.

 - The `<form>` tag has `update="members"`. The presence of this attribute turns the form into an ajax form. Submitting the form will cause the "members" part to be updated.

 - The `<name-one>` tag creates an input field for the user association with auto-completion.


gitorial-059: [view on github](http://github.com/Hobo/agility-gitorial/commit/514828d0cec9d5201d73f5167b2f58836552cfb8), [download patch](http://github.com/Hobo/agility-gitorial/commit/514828d0cec9d5201d73f5167b2f58836552cfb8.patch)
{: .commit}




<a name='removing-members'> </a>

## Removing members

The sidebar we just implemented has an obvious draw-back -- there's no way to remove members. In typical RESTful style, removing a member is achieved by deleting a membership. What we'd like is a delete button on each card that removes the membership. That means what we really want are *Membership* cards in the sidebar (at the moment they are User cards). So, in `projects/show.dryml`, change:

    ::: app/views/projects/show.dryml
    @@ -10,11 +10,11 @@
       </table-plus>
       </collection:>
     
       <aside:>
         <h2>Project Members</h2>
    -    <collection:members part="members"/>
    +    <collection:memberships part="members"/>
     
         <form:memberships.new update="members" reset-form refocus-form>
           <div>
             Add a member:
             <name-one:user/>
    
{: .diff}



gitorial-060: [view on github](http://github.com/Hobo/agility-gitorial/commit/2f5a6e95b0a3a46ff1e9142db98813a915020a2f), [download patch](http://github.com/Hobo/agility-gitorial/commit/2f5a6e95b0a3a46ff1e9142db98813a915020a2f.patch)
{: .commit}




<a name='removing-members-2'> </a>

We have a problem -- the membership card doesn't display the user's name. There are two ways we could fix this. We could either customise the global membership card using `<extend tag="card" for="Membership">` in `application.dryml`, or we could customise *this particular usage* of the membership card. Let's do the latter. Modify the `<collection:memberships>` as follows:

    ::: app/views/projects/show.dryml
    @@ -10,11 +10,13 @@
       </table-plus>
       </collection:>
     
       <aside:>
         <h2>Project Members</h2>
    -    <collection:memberships part="members"/>
    +    <collection:memberships part="members">
    +      <card><heading:><a:user/></heading:></card>
    +    </collection>
     
         <form:memberships.new update="members" reset-form refocus-form>
           <div>
             Add a member:
             <name-one:user/>
    
{: .diff}



gitorial-061: [view on github](http://github.com/Hobo/agility-gitorial/commit/bc0ea66397a2da406e547e2904e5c80855b0ac3e), [download patch](http://github.com/Hobo/agility-gitorial/commit/bc0ea66397a2da406e547e2904e5c80855b0ac3e.patch)
{: .commit}




<a name='fix-front-page'> </a>

## Final steps

There's just a couple of things to do to round this part of the tutorial off. Firstly, you might have noticed there's no place to create a new project at the moment. There's also no place that list "Projects you have joined". We'll add both of those to the front page, in the place we currently have a list of "Your projects". Replace that entire `<section class="content-body">` with the following DRYML:

    ::: app/views/front/index.dryml
    @@ -21,12 +21,17 @@
     
     
           </section>
         </header>
     
    -    <section class="content-body" if="&logged_in?">
    +    <section with="&current_user" class="content-body" if="&logged_in?">
           <h3>Your Projects</h3>
    -      <collection:projects with="&current_user"><card without-creator-link/></collection>
    +      <collection:projects><card without-creator-link/></collection>
    +
    +      <a:projects action="new">New Project</a>
    +
    +      <h3>Projects you have joined</h3>
    +      <collection:joined-projects><card without-creator-link/></collection>
         </section>
       </content:>
     
     </page>
    
{: .diff}


Notice how we set the context on the entire section to be the current user (`with="&current_user"`). That makes the markup inside the section much more compact and easy to read.


gitorial-062: [view on github](http://github.com/Hobo/agility-gitorial/commit/b1fb6a7407c39cc63a2eed19efdff0181026a8ea), [download patch](http://github.com/Hobo/agility-gitorial/commit/b1fb6a7407c39cc63a2eed19efdff0181026a8ea.patch)
{: .commit}




<a name='granting-write-access-to-others'> </a>

It's not enough just to allow others to view your projects, you need to allow some people to make changes, too. The goal of this part of the tutorial is to add a "Contributor" checkbox next to each person in the side-bar.

Implementing this is left as an exercise for the reader. The steps are:

1. Add a boolean `contributor` field to the `ProjectMembership` model.
2. Modify the permissions of stories and tasks so that users with `contributor=true` on their project membership have update permission for the project.
3. Use the `<editor>` tag to create an ajax editor for the `contributor` field in the ProjectMembership card.

That's all the hints we're going to give you for this one -- good luck!

Ok, one more hint, here's some associations that might be handy in the Project model:

    has_many :contributor_memberships, :class_name => "ProjectMembership", :scope => :contributor
    has_many :contributors, :through => :contributor_memberships, :source => :user
{: .ruby}

And a helper method that might come in handy when implementing your permission methods:

    def accepts_changes_from?(user)
       user.administrator? || user == owner || user.in?(contributors)
    end
{: .ruby}


gitorial-063: [view on github](http://github.com/Hobo/agility-gitorial/commit/6917d205ce3c636f3678887f4e9374d4c1972b57), [download patch](http://github.com/Hobo/agility-gitorial/commit/6917d205ce3c636f3678887f4e9374d4c1972b57.patch)
{: .commit}




<a name='breaking-out-of-the-box'> </a>

# Breaking out of the Box

Up until now, we've highlighted cool features of Hobo, and made
everything look easy.  You can't blame us, can you?

Hobo makes the first 90% of your application really easy, but we
cannot anticipate everything.  That last 10% is what makes your
application special, and cannot be included in any toolkit.

Most rapid application generators put you inside a box -- if you stay
inside the box, everything is easy.  Some won't let you break out of
the box, and others make it very difficult.

With Hobo there is no box.  More and more customization is required the
further you stray away from what has been anticipated, but the border
is not sharp.

In essence, Hobo and DRYML support five different ways of customizing
a widget, page or action.

## Parametrization

Most of what you have seen so far in this tutorial has been
parametrization.  In DRYML you can set the attributes or parameters of
a tag you invoke, in Ruby you can change the parameters to functions
you invoke.

## Extension

In DRYML, there is a tag called
[extend](/manual/dryml-guide#customising_and_extending_tags).  Extend
allows you to redefine an existing tag while reusing the existing
definition.  This allows you to add to the tag or change its default
parametrization.

You saw an example of extension in DRYML in [Customizing
Views](#customising_views).

## Redefinition

The next level of customization is to redefine a tag or function.
`app/views/taglibs/application.dryml` gets loaded after the RAPID
library and the auto-generated DRYML, so if you redefine a tag, your
definition will be used instead of the library definition.

Perhaps the first thing that many developers customize is the
navigation bar.  In our little tutorial, we want to remove the "Story
Status" tab.

The nice thing about redefining a tag is that you can use the existing
definition for a little bit of cut and paste.  Cutting and pasting is
generally frowned upon -- DRYML includes "don't repeat yourself",
after all, but sometimes we do it anyways.  In our case, we'll be
cutting and pasting from the top of `view/taglibs/auto/rapid/pages.dryml`.

    ::: app/views/taglibs/application.dryml
    @@ -1,3 +1,8 @@
     <!-- this file is included by front_site.dryml, admin_site.dryml et al, so
     you can place common code in this file. -->
     
    +<def tag="main-nav">
    +  <navigation class="main-nav" merge-attrs>
    +    <nav-item href="#{base_url}/">Home</nav-item>
    +  </navigation>
    +</def>
    
{: .diff}


You will notice that we've removed the StoryStatus line.  We've also
removed the "param" attributes.  Nobody is going to be parameterzing
our redefinition, so let us make it a little simpler.

## Defining new tags

Creating new tags is outside of the scope of this tutorial.  Creating
new tags lets you avoid cutting and pasting, and lets you reuse your
code throughout your project and into other projects.  For more
information on DRYML, see the [manual](/manual).

## Replacement

When you want to do something completely different, you can completely
bypass the existing tags.   `app/views/projects/show.dryml` can
contain raw HTML with little or no DRYML.  You can also bypass DRYML
and create `app/views/projects/show.html.erb` and use standard Ruby on
Rails techniques.  Hobo models and controllers follow standard Rails
conventions, so completely custom views can be used without defining
custom controllers and models or vice versa.


gitorial-064: [view on github](http://github.com/Hobo/agility-gitorial/commit/d288761b2e9887316df45946c21728cb80bac382), [download patch](http://github.com/Hobo/agility-gitorial/commit/d288761b2e9887316df45946c21728cb80bac382.patch)
{: .commit}




<a name='install-shoulda-and-factory-girl'> </a>

# Unit Testing

They say that an application without tests is a broken application, so
lets add some unit tests.

When starting out with Rails testing, you are faced with a bewildering
array of choices.   It's outside the scope of this tutorial to guide
you through these choices, but I will give you one piece of advice:
any tests are better than no tests.   Do not get caught up in
"analysis paralysis" -- don't spend so much time trying to analyze
which choices are right for you that you don't do any testing at all.
If you change your mind later, it isn't that hard to translate tests
from one environment to another.

Also be aware that choices that are good for one area are not
necessarily good for another.  You might use a factory for unit
testing, but fixtures for integration testing, for example.

For this tutorial we're going to go with a more mainstream choice:
Test::Unit with Shoulda for the test DSL and FactoryGirl with Faker to
create test data.

I'm going to give a special shout out here to
[IRT](https://github.com/ddnexus/irt),  which is written by the same
man who ported Hobo to Rails3: Domizio Demichelis.  It offers a unique
paradigm that makes it easy to simultaneously develop code and tests.
Highly recommended.

We aren't going to use IRT in this tutorial, but there's nothing
stopping you from writing both Test::Unit and IRT tests in the same
application.

When we initially generated our application, we didn't customize our
test framework.   So let's revisit that decision.

    $ hobo generate test_framework shoulda --fixture_replacement=factory_girl
    $ bundle install


gitorial-065: [view on github](http://github.com/Hobo/agility-gitorial/commit/159c9e635302f863393c516f453a6a1f18ec254b), [download patch](http://github.com/Hobo/agility-gitorial/commit/159c9e635302f863393c516f453a6a1f18ec254b.patch)
{: .commit}




<a name='fixup-test-helper'> </a>

The generators did not replace our old fixtures based
`test_helper.rb`, so lets fix that up:

    ::: test/test_helper.rb
    @@ -1,13 +1,9 @@
     ENV["RAILS_ENV"] = "test"
     require File.expand_path('../../config/environment', __FILE__)
     require 'rails/test_help'
     
     class ActiveSupport::TestCase
    -  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
    -  #
    -  # Note: You'll currently still have to declare fixtures explicitly in integration tests
    -  # -- they do not yet inherit this setting
    -  fixtures :all
    +  include Factory::Syntax::Methods
     
       # Add more helper methods to be used by all tests here...
     end
    
{: .diff}



gitorial-066: [view on github](http://github.com/Hobo/agility-gitorial/commit/a34024a9af1a922709f3239a1659831916cd3830), [download patch](http://github.com/Hobo/agility-gitorial/commit/a34024a9af1a922709f3239a1659831916cd3830.patch)
{: .commit}




<a name='user-factory'> </a>

## Your First Unit Test

Unit tests are by far the easiest type of test to write in Rails, as
well as the quickest to run.  However, they can only test code in your
models.  For this and other reasons, you should try and put as much of
your program's logic into your model as possible.   (Google for
"skinny controller, fat model" for other reasons.)

Because Agility is a demonstration program, it really does not have
much logic in the models.   Looking through our models, we can quickly
determine that the User model is the heaviest, so let us test that.

We're going to need some data to test, so let us set up a factory:

    ::: test/factories/user_factory.rb
    @@ -0,0 +1,15 @@
    +FactoryGirl.define do
    +  factory :user do
    +    name 'Test User'
    +    email_address 'test@example.com'
    +    administrator false
    +    state "active"
    +  end
    +
    +  factory :admin, :class => User do
    +    name 'Admin User'
    +    email_address 'admin@example.com'
    +    administrator true
    +    state "active"
    +  end
    +end
    
{: .diff}



gitorial-067: [view on github](http://github.com/Hobo/agility-gitorial/commit/60e1f157484b2fd4c152d92b82401b0230993a18), [download patch](http://github.com/Hobo/agility-gitorial/commit/60e1f157484b2fd4c152d92b82401b0230993a18.patch)
{: .commit}




<a name='trivial-unit-test'> </a>

Let us write a simple test to verify our factory works:

    ::: test/unit/user_test.rb
    @@ -1,7 +1,8 @@
     require 'test_helper'
     
     class UserTest < ActiveSupport::TestCase
    -  # test "the truth" do
    -  #   assert true
    -  # end
    +  test "the truth" do
    +    @user = create :user
    +    assert_equal "Test User", @user.name
    +  end
     end
    
{: .diff}


now type

    $ rake test:units

to verify that your tests run.


gitorial-068: [view on github](http://github.com/Hobo/agility-gitorial/commit/9bc86d971f9f7318fbe1cfd7ca1b80a473470589), [download patch](http://github.com/Hobo/agility-gitorial/commit/9bc86d971f9f7318fbe1cfd7ca1b80a473470589.patch)
{: .commit}




<a name='user-permissions-test'> </a>

## User Permissions Test

Let us now replace our trivial test with real tests.   Looking at
`user.rb` the function most in need of testing is probably
`update_permitted?`.

The Hobo permission system is not invoked when you simply change
attributes on a model.  For example, `@user.name = "Another Name"`
will always succeed even though `User#update_permitted?` sometimes
doesn't allow the name to change.  To invoke the Hobo permissions
system, we need to do two things: set the `acting_user` for the model,
and change the attributes through the Hobo API.  We can do both using
(`user_update_attributes`)[/manual/permissions#the_permissions_api].

Knowing that, let's create a test:

    ::: test/unit/user_test.rb
    @@ -1,8 +1,23 @@
     require 'test_helper'
     
     class UserTest < ActiveSupport::TestCase
    -  test "the truth" do
    -    @user = create :user
    -    assert_equal "Test User", @user.name
    +  context "user permissions" do
    +    setup do
    +      @admin = create(:admin)
    +      @user = create(:user)
    +      @user2 = create(:user, :name => "User 2", :email_address => "user2@example.com")
    +    end
    +
    +    should "only let the admin change the admin flag" do
    +      assert_nothing_raised { @user.user_update_attributes(@admin, {:administrator => true}) }
    +      assert_equal true, @user.administrator
    +      assert_raise(Hobo::PermissionDeniedError) { @user.user_update_attributes(@user, {:administrator => false}) }
    +    end
    +
    +    should "only let an admin or the user change their email address" do
    +      assert_nothing_raised { @user.user_update_attributes(@admin, {:email_address => "foo@example.com"}) }
    +      assert_nothing_raised { @user.user_update_attributes(@user, {:email_address => "bar@example.com"}) }
    +      assert_raise(Hobo::PermissionDeniedError) { @user.user_update_attributes(@user2, {:email_address => "baz@example.com"}) }
    +    end
       end
     end
    
{: .diff}



gitorial-069: [view on github](http://github.com/Hobo/agility-gitorial/commit/b52e7a3c0a9729c09d3de7ded72d100d2c65a93a), [download patch](http://github.com/Hobo/agility-gitorial/commit/b52e7a3c0a9729c09d3de7ded72d100d2c65a93a.patch)
{: .commit}




<a name='install-selenium'> </a>

# Integration Testing

It's not a real application without tests.  We're going to use
[Selenium](http://seleniumhq.org/) to do some integration testing.

The easiest way to use selenium with rails is to use `capybara`.   We'll
also need database_cleaner because capybara/selenium does not support
transactional fixtures.

Add to your Gemfile:

    group :development, :test do
      gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
      gem 'database_cleaner;
    end


gitorial-070: [view on github](http://github.com/Hobo/agility-gitorial/commit/26b67765a586107938833df1b1d44e4d279128ce), [download patch](http://github.com/Hobo/agility-gitorial/commit/26b67765a586107938833df1b1d44e4d279128ce.patch)
{: .commit}




<a name='create-simple-integration-test'> </a>

The next step is to create an integration test using Capybara.  There
are two parts to this: the magic boilerplate and the meat of the test.

For the magic boiler plate, a quick Google gives us [this
post](http://blag.ahax.de/post/1581758817/using-capybara-with-plain-rails-integration-tests-and).

For the meat of the test, we refer to the [capybara
documentation](https://github.com/jnicklas/capybara/blob/master/README.rdoc).
Look at the section titled `The DSL`, which contains links to
appropriate sections in the rdoc.

This test is actually part of the Hobo system test suite.

    ::: app/models/user.rb
    @@ -19,11 +19,11 @@
       has_many :joined_projects, :through => :project_memberships, :source => :project
     
       # This gives admin rights and an :active state to the first sign-up.
       # Just remove it if you don't want that
       before_create do |user|
    -    if !Rails.env.test? && user.class.count == 0
    +    if user.class.count == 0
           user.administrator = true
           user.state = "active"
         end
       end
     
    ::: test/integration/create_account_test.rb
    @@ -0,0 +1,152 @@
    +# -*- coding: utf-8 -*-
    +require 'test_helper'
    +require 'capybara'
    +require 'capybara/dsl'
    +require 'database_cleaner'
    +
    +Capybara.app = Agility::Application
    +Capybara.default_driver = :rack_test
    +DatabaseCleaner.strategy = :truncation
    +
    +class CreateAccountTest < ActionDispatch::IntegrationTest
    +  include Capybara::DSL
    +  self.use_transactional_fixtures = false
    +
    +  setup do
    +    DatabaseCleaner.start
    +  end
    +
    +  teardown do
    +    #DatabaseCleaner.clean
    +  end
    +
    +  test "create account" do
    +    Capybara.current_driver = :selenium
    +    visit root_path
    +
    +    # create administrator
    +    fill_in "user_name", :with => "Admin User"
    +    fill_in "user_email_address", :with => "admin@example.com"
    +    fill_in "user_password", :with => "test123"
    +    fill_in "user_password_confirmation", :with => "test123"
    +    click_button "Register Administrator"
    +    assert has_content?("You are now the site administrator")
    +    click_link "Log out"
    +
    +    # signup
    +    click_link "Signup"
    +    fill_in "user_name", :with => "Test User"
    +    fill_in "user_email_address", :with => "test@example.com"
    +    fill_in "user_password", :with => "test123"
    +    fill_in "user_password_confirmation", :with => "test123"
    +    click_button "Signup"
    +    assert has_content?("Thanks for signing up!")
    +    find("#activation-link").click
    +    click_button "Activate"
    +
    +    # log in
    +    click_link "Login"
    +    fill_in "login", :with => "test@example.com"
    +    fill_in "password", :with => "test123"
    +    click_button "Login"
    +    assert has_content?("You have logged in.")
    +
    +    # create First Project/Story/Task
    +    click_link "New Project"
    +    fill_in "project_name", :with => "First Project"
    +    click_button "Create Project"
    +    assert has_content?("The Project was created successfully")
    +
    +    click_link "New Story"
    +    fill_in "story_title", :with => "First Story"
    +    fill_in "story[body]", :with => "First Story"
    +    click_button "Create Story"
    +    assert has_content?("The Story was created successfully")
    +
    +    fill_in "task_description", :with => "First Task"
    +    find("div.task-users select").select("Test User")
    +    click_button "Add"
    +    assert has_content?("The Task was created successfully")
    +
    +    # create Second User
    +    click_link "Log out"
    +    click_link "Signup"
    +    fill_in "user_name", :with => "Second User"
    +    fill_in "user_email_address", :with => "second@example.com"
    +    fill_in "user_password", :with => "second2"
    +    fill_in "user_password_confirmation", :with => "second2"
    +    click_button "Signup"
    +    assert has_content?("Thanks for signing up!")
    +    click_link "activation-link"
    +    click_button "Activate"
    +    click_link "Login"
    +    fill_in "login", :with => "second@example.com"
    +    fill_in "password", :with => "second2"
    +    click_button "Login"
    +    assert has_content?("You have logged in.")
    +    assert has_content?("New Project")
    +
    +    #click_link "New Project"
    +    #fill_in "project_name", :with => "Second Project"
    +    #click_button "Create Project"
    +
    +    # switch to Test User
    +    click_link "Log out"
    +    click_link "Login"
    +    fill_in "login", :with => "test@example.com"
    +    fill_in "password", :with => "test123"
    +    click_button "Login"
    +    assert has_content?("Logged in as Test User")
    +
    +    # add Second User to First Task
    +    click_link "First Project"
    +    click_link "First Story"
    +    click_link "Edit Task"
    +    find("div.task-users select").select("Second User")
    +    click_button "Save Task"
    +    assert has_content?("Assigned users: Test User, Second User")
    +
    +    # log in as Administrator
    +    click_link "Log out"
    +    click_link "Login"
    +    fill_in "login", :with => "admin@example.com"
    +    fill_in "password", :with => "test123"
    +    click_button "Login"
    +    assert has_content?("Logged in as Admin User")
    +
    +    # define statuses
    +    visit "/story_statuses"
    +    click_link "New Story status"
    +    fill_in "story_status_name", :with => "discussion"
    +    click_button "Create Story status"
    +    assert has_content?("There is one Story status")
    +    click_link "New Story status"
    +    fill_in "story_status_name", :with => "documentation"
    +    click_button "Create Story status"
    +    assert has_content?("There are 2 Story statuses")
    +
    +    # log in as Test User
    +    click_link "Log out"
    +    click_link "Login"
    +    fill_in "login", :with => "test@example.com"
    +    fill_in "password", :with => "test123"
    +    click_button "Login"
    +    assert has_content?("Logged in as Test User")
    +
    +    # add status to First Story
    +    click_link "Home"
    +    click_link "First Project"
    +    click_link "First Story"
    +    find("select.story_status").select("discussion")
    +    #wait_for_visible "css=div.ajax-progress"
    +    #wait_for_not_visible "css=div.ajax-progress"
    +
    +    click_link "« Back to Project First Project"
    +    assert_equal "discussion", find("span.story-status-name").text
    +
    +    # check filtering
    +    select "documentation", :from => "status"
    +    assert has_content?("No stories match your criteria")
    +
    +  end
    +end
    
{: .diff}


When your test is written, run it with

    $ rake test:integration


gitorial-071: [view on github](http://github.com/Hobo/agility-gitorial/commit/8a4d01d92429509ef7628c434655764d1178d010), [download patch](http://github.com/Hobo/agility-gitorial/commit/8a4d01d92429509ef7628c434655764d1178d010.patch)
{: .commit}




<a name='translating'> </a>

# Translating the Application

A lot of Hobos speak languages other than English, so let's translate our application so they feel at home.

First we'll make a couple of temporary tweaks to our configuration.

    ::: config/application.rb
    @@ -42,11 +42,11 @@
         # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
         # config.time_zone = 'Central Time (US & Canada)'
     
         # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
         # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    -    # config.i18n.default_locale = :de
    +    config.i18n.default_locale = :en
     
         # Configure the default encoding used in templates for Ruby 1.9.
         config.encoding = "utf-8"
     
         # Configure sensitive parameters which will be filtered from the log file.
    ::: config/environments/development.rb
    @@ -34,6 +34,9 @@
       # Do not compress assets
       config.assets.compress = false
     
       # Expands the lines which load the assets
       config.assets.debug = true
    +  
    +  # turn this off after you're done translating
    +  config.hobo.show_translation_keys = true
     end
    
{: .diff}


The tweak to `config/application.rb` shows you where to change the default locale.  Normally you want to set the locale dynamically, perhaps based on the domain name.   However, that's outside the scope of this tutorial.   See [the Rails guide to i18n](http://guides.rubyonrails.org/i18n.html) for more information.

The tweak to `config/environments/development.rb` tells Hobo to show
the keys used to generate each string.  This makes the application
look like a mess, so you'll want to turn this off as soon as you have
a handle on your translation.


gitorial-072: [view on github](http://github.com/Hobo/agility-gitorial/commit/0f6fc252c8b6b84591eed282a13921aa4966b7bb), [download patch](http://github.com/Hobo/agility-gitorial/commit/0f6fc252c8b6b84591eed282a13921aa4966b7bb.patch)
{: .commit}




<a name='add-translation-keys'> </a>

To add translations, you must add translation keys to your code.

For example, to translate one of the strings on the front page:

    ::: app/views/front/index.dryml
    @@ -22,11 +22,11 @@
     
           </section>
         </header>
     
         <section with="&current_user" class="content-body" if="&logged_in?">
    -      <h3>Your Projects</h3>
    +      <h3><t key="front_title">Your Projects</t></h3>
           <collection:projects><card without-creator-link/></collection>
     
           <a:projects action="new">New Project</a>
     
           <h3>Projects you have joined</h3>
    
{: .diff}



gitorial-073: [view on github](http://github.com/Hobo/agility-gitorial/commit/ceb800b8727448ebb552624d2caf3485cbccc4eb), [download patch](http://github.com/Hobo/agility-gitorial/commit/ceb800b8727448ebb552624d2caf3485cbccc4eb.patch)
{: .commit}




<a name='add-translations'> </a>

Translations appear in the `config/locales` directory.  We'll edit
`app.en.yml` with our translations.

    ::: config/locales/app.en.yml
    @@ -2,10 +2,16 @@
     # e.g.
     
     en:
       hello: "Hello world"
     
    +  front_title: "Projects you created"
    +
    +  project:
    +    collection:
    +      empty_message: "You do not have any projects"
    +
     #  attributes:
     #    created_at: Created at
     #    updated_at: Updated at
     #
     #  activerecord:
    
{: .diff}



gitorial-074: [view on github](http://github.com/Hobo/agility-gitorial/commit/9f7c3a3b9670058d2c84303586dc64285500aa56), [download patch](http://github.com/Hobo/agility-gitorial/commit/9f7c3a3b9670058d2c84303586dc64285500aa56.patch)
{: .commit}




<a name='rest-of-tutorial'> </a>

# Ideas for extending the application

## Milestones

A pretty obvious addition is to have project milestones, and to be able to associate stories with milestones.

## Add comments to stories

It's always useful to be able to have a discussion around things, and a trail of comments is a nice easy way to support this.

## Better users/show page

The current `users/show` page could be improved a lot. For example, it doesn't give any indication of the different projects that stories belong to. What else would be useful on this page?


# Appendix -- Styling the Application

**NOTE: This section is a bit out of date. It will mostly work but there might be some style glitches**

The default Hobo theme “Clean” provides comprehensive but minimal styling for all of Hobo’s generic pages and tags. When styling your app you have a choice between creating your own theme from scratch or tweaking an existing theme to suit your needs. The Clean theme has been designed with this in mind; it can be adapted to look very different with only a small amount of effort.

In this section we will adapt our existing theme to create a new look for our app. We will make our changes in `public/stylesheets/application.css`, which is initially empty. This stylesheet is applied after our theme stylesheet so we can override the theme's styles here instead of editing the theme stylesheet directly. This approach means that we can upgrade the theme in the future with minimal effort, although it also means that our stylesheets will be bigger than they could be, so the approach is better suited to small and medium sized projects. For larger projects it might be better to create a new theme, perhaps based on an existing one, or do away with themes altogether and do all the styling in the `application.css` stylesheet.

In order to override our existing theme styles we need to know about the styles that are being applied. For this we can look at the existing theme file in `public/hobothemes/clean/stylesheets/clean.css`. Another good source for this information is by using [Firebug](http://www.firebug.com) in Firefox where we can examine the various page elements to discover what styling is being applied.

Hobo's tags add various CSS classes to the output elements to help with styling. These are typically the name of the tag that was used to generate the output and the name of the model or field corresponding to `this` context. For example:

An index page for "Project" adds the following classes to `<body>`:
`<body class="index-page project">`

A show page for "Project" adds the following classes to `<body>`:
`<body class="show-page project">` on `/projects/1`

The `<view>` tag applied to a "Project" name will output:
`<span class="view project-name">My Project</span>`

The `<card>` tag applied to a "Project" will output:
`<div class="card project linkable">`

With these classes it becomes very easy to style specific elements on the page. For example:

`.card.project` - Style all "project" cards
`.index-page .card.project` - Style "project" cards on index pages
`.show-page.project .card.story` - Style "story" cards on the "project" show page

We'll now add some styling to `public/stylesheets/application.css` to make our Agility app look a bit different.

The first thing we'll do is switch from a "boxed in" look to an horizontally open style. To do this we'll use a background image to draw a horizontal top banner across the whole page and change the page background colour to white:

    html, body {
    	background-image: url(/images/header.png);
    	background-position: top left;
    	background-repeat: repeat-x;
    	background-color: white;
    }

Next we'll make the page a bit wider and make the header taller:

    body {width: 860px; background: none;}

    .page-header {height: 176px; padding: 0; margin-top: 0;}

Next we'll want to position the contents of the page header differently since we've increased its height. We'll start by increasing the size and padding on the application name:

    .page-header h1 {
    	margin: 0; padding: 50px 30px 0;
    	font-family: "Lucida Grande", Tahoma, Arial, sans-serif; font-size: 42px; font-weight: bold;
    	text-transform: lowercase;
    }

Next we'll move the main navigation bar to the top right of the page and change the way it looks:

    .page-header .main-nav {
    	position: absolute; top: 0; right: 0;
    }
    .page-header .main-nav li {margin-right: 1px;}
    .main-nav a, .main-nav a:hover {
    	padding: 37px 6px 5px; min-width: 95px;
    	text-shadow: none;
    	border: 1px solid black; border-width: 0 0 0 1px; background-color: #D61951;
    }
    .main-nav a:hover {
    	background-color: #AD163D;
    }

Next we need to reposition the account navigation and search bar. We'll also need to reposition our development-mode user changer:

    .account-nav {
    	position: absolute; top: 70px; right: 15px;
    	font-size: 11px;
    }
    .account-nav a {color: #bbb;}

    .page-header div.search {
    	top: auto; bottom: 0; right: 5px; z-index: 10;
    }
    select.dev-user-changer {top: 100px; left: auto; right: 15px; height: auto;}

Now that we've finished the page header we want to customise the content section of the page:

    .page-content {background: none;}
    .content-header, .content-body {margin: 0 25px 15px;}

    body {
    	color: #555;
    	font: 14px "Trebuchet MS", Arial, sans-serif; line-height: 150%;
    }
    h1, h2, h3 {font-weight: normal; line-height: 100%; text-transform: lowercase; color: #D61951;}
    h1 {margin: 20px 0 10px; font-size: 26px;}
    h2 {margin: 15px 0 10px; font-size: 18px;}
    h3 {margin: 10px 0 5px;  font-size: 16px;}
    h4 {margin: 10px 0 5px;  font-size: 14px;}
    h5 {margin: 10px 0 5px;  font-size: 12px;}
    h6 {margin: 10px 0 5px;  font-size: 10px;}

    .show-page .content-header, .primary-collection h2 {border-bottom: 1px solid #ccc;}
    .front-page .welcome-message {border: none;}

    .card {border: none; background: #f2f2f2;}
    a, a:hover, .card a, .card a:hover {background: none; color: #1D7D39;}

Finally we'll customise the look of the aside section which is used on the project show page:

    .aside {padding: 20px; margin: 40px 25px 0 0;}
    .aside-content h2, .aside-content h3 {border-bottom: 1px solid #ccc; margin-top: 0;}


gitorial-075: [view on github](http://github.com/Hobo/agility-gitorial/commit/d64341e2e6fcd7ab85f7fd5960a352555df56ccc), [download patch](http://github.com/Hobo/agility-gitorial/commit/d64341e2e6fcd7ab85f7fd5960a352555df56ccc.patch)
{: .commit}
