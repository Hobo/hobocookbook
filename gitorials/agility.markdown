


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


22b251: [view on github](http://github.com/Hobo/agility-gitorial/commit/22b251baf7ed3d1964ac9df6c81537a1eff27fff), [download 51-intro.patch](/patches/agility/51-intro.patch)
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


fc0d8f: [view on github](http://github.com/Hobo/agility-gitorial/commit/fc0d8fe43320f8ef65b7d5aa4904685710b1a459), [download 8f-run-hobo.patch](/patches/agility/8f-run-hobo.patch)
{: .commit}




<a name='interface-first-hobo-style'> </a>

## Interface first Hobo style

The next thing we're going to do is sketch out our models. If you're a fully signed up devotee of the Rails Way, that should ring a few alarm bells. What happened to [interface first](http://gettingreal.37signals.com/ch09_Interface_First.php)? We do believe in Interface First. Absolutely. But for Hobos, interface first means first priority, not first task.

The reason is, we think we've rewritten this rule:

> Design is relatively light. A paper sketch is cheap and easy to change. html designs are still relatively simple to modify (or throw out). That's not true of programming. Designing first keeps you flexible. Programming first fences you in and sets you up for additional costs.

In our experience, experimenting with an app by actually building a prototype with Hobo, is actually quicker than creating html designs. How's that for getting real? We could waffle for a good while on this point, but that's probably best saved for a blog post. For now let's dive in and get this app running.


93d7ba: [view on github](http://github.com/Hobo/agility-gitorial/commit/93d7ba45c488ca1b4b4f1d40d980093e86eaf42f), [download ba-interface-first-hobo-style.patch](/patches/agility/ba-interface-first-hobo-style.patch)
{: .commit}




<a name='From: Bryan Larsen <bryan@larsen.st>'> </a>
Date: 2013-01-08 10:12:13 -0500

generate-initial-models

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


279605: [view on github](http://github.com/Hobo/agility-gitorial/commit/27960570d224d991f2a3b9c4c15fca9e809fcb15), [download 05-From: Bryan Larsen <bryan@larsen.st>.patch](/patches/agility/05-From: Bryan Larsen <bryan@larsen.st>.patch)
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


d2987f: [view on github](http://github.com/Hobo/agility-gitorial/commit/d2987f5c21e9b1856f51894121a22e64868ea82a), [download 7f-add-initial-associations.patch](/patches/agility/7f-add-initial-associations.patch)
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


3ed47e: [view on github](http://github.com/Hobo/agility-gitorial/commit/3ed47e8db28d7e412fd71adb7f9f9abc73960d95), [download 7e-migration-to-create-initial-models.patch](/patches/agility/7e-migration-to-create-initial-models.patch)
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



03fbdd: [view on github](http://github.com/Hobo/agility-gitorial/commit/03fbdd89ddcdef09e781f057d34a676299c52cc3), [download dd-viewhints-children.patch](/patches/agility/dd-viewhints-children.patch)
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


af7161: [view on github](http://github.com/Hobo/agility-gitorial/commit/af71612d1142892bcfb38d855a853c15727161da), [download 61-remove-project-actions.patch](/patches/agility/61-remove-project-actions.patch)
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


b6e018: [view on github](http://github.com/Hobo/agility-gitorial/commit/b6e0184bcf803f9d8d583cd2db7b3380c63d8a28), [download 18-auto-actions-for-project.patch](/patches/agility/18-auto-actions-for-project.patch)
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


96022f: [view on github](http://github.com/Hobo/agility-gitorial/commit/96022f1c5d85f93c334c1be99942f20107969714), [download 2f-auto-actions-for-story.patch](/patches/agility/2f-auto-actions-for-story.patch)
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


9daf4a: [view on github](http://github.com/Hobo/agility-gitorial/commit/9daf4aaf69f9ed779f99332fa4e3b815a91077ac), [download 4a-more-auto-actions.patch](/patches/agility/4a-more-auto-actions.patch)
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


b0bfe5: [view on github](http://github.com/Hobo/agility-gitorial/commit/b0bfe53459376807296c20fcd5fd763eda05b5a5), [download e5-permissions-1.patch](/patches/agility/e5-permissions-1.patch)
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


7136b8: [view on github](http://github.com/Hobo/agility-gitorial/commit/7136b8497b0a1ba31aefc414c7035d24748ea502), [download b8-permissions-for-data-integrity.patch](/patches/agility/b8-permissions-for-data-integrity.patch)
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


9ddb1f: [view on github](http://github.com/Hobo/agility-gitorial/commit/9ddb1f73c07885bf94231cd74b04e59cab2b1a37), [download 1f-permissions-associations.patch](/patches/agility/1f-permissions-associations.patch)
{: .commit}




<a name='customizing-views-1'> </a>

# Customising views

It's pretty surprising how far you can get without even touching the view layer. That's the way we like to work with Hobo - get the models and controllers right and the view will probably get close to what you want. From there you can override just those parts of the view that you need to.

We do that using the DRYML template language which is part of Hobo. DRYML is tag based -- it allows you to define and use your own tags right alongside the regular HTML tags. Tags are like helpers, but a lot more powerful. DRYML is quite unlike other tag-based template languages, thanks to features like the implicit context and nestable parameters. DRYML is also an extension of ERB so you can still use the ERB syntax you're familiar with from Rails.

DRYML is probably the single best part of Hobo. It's very good at high-level re-use because it allows you to make very focussed changes if a given piece of pre-packaged HTML is not *quite* what you want.

A full coverage of DRYML is well beyond the scope of this tutorial. Instead we're going to take a few specific examples of changes we'd like to make to Agility, and see how they're done.


b00869: [view on github](http://github.com/Hobo/agility-gitorial/commit/b008694fdd6a6b2ae9b3c50832d5c2a39005538b), [download 69-customizing-views-1.patch](/patches/agility/69-customizing-views-1.patch)
{: .commit}




<a name='add-users-to-tasks'> </a>

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


fe625a: [view on github](http://github.com/Hobo/agility-gitorial/commit/fe625aaa0e1cc4ff7781497b7edc820ad08234a5), [download 5a-add-users-to-tasks.patch](/patches/agility/5a-add-users-to-tasks.patch)
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

[DRYML Guide]: http://hobocentral.net/docs/dryml


1dd4e0: [view on github](http://github.com/Hobo/agility-gitorial/commit/1dd4e0bf0fee6e9bc4b2678b616e1eeba87f7203), [download e0-add-task-summary-to-user-page.patch](/patches/agility/e0-add-task-summary-to-user-page.patch)
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


a18cf4: [view on github](http://github.com/Hobo/agility-gitorial/commit/a18cf4bc1c494a9a0035032668122c3ea46bcb6b), [download f4-searchable-sortable-table.patch](/patches/agility/f4-searchable-sortable-table.patch)
{: .commit}




<a name='stories-table-add-count'> </a>

We could also add a column showing the number of tasks in a story. Change to `fields="this, tasks.count, status"` and see that a column is added with a readable title "Tasks Count".


e52326: [view on github](http://github.com/Hobo/agility-gitorial/commit/e5232631c86a48eba07f5d58f3492e68d171dc53), [download 26-stories-table-add-count.patch](/patches/agility/26-stories-table-add-count.patch)
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


f3e180: [view on github](http://github.com/Hobo/agility-gitorial/commit/f3e1808c2af429925ce034f075d8eb98a3e7fa75), [download 80-stories-table-add-search.patch](/patches/agility/80-stories-table-add-search.patch)
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



c5e753: [view on github](http://github.com/Hobo/agility-gitorial/commit/c5e7530977bd98c46f8dc9623a826dcd53c7804c), [download 53-setup-smtp.patch](/patches/agility/53-setup-smtp.patch)
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



4f1d7b: [view on github](http://github.com/Hobo/agility-gitorial/commit/4f1d7bc1527e0ee377e86167621468125aeb349c), [download 7b-add-flash-message.patch](/patches/agility/7b-add-flash-message.patch)
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



d0b64f: [view on github](http://github.com/Hobo/agility-gitorial/commit/d0b64f8d797a770e33c2e5cd11c5277eecbfc865), [download 4f-display-activation-link.patch](/patches/agility/4f-display-activation-link.patch)
{: .commit}




<a name='odds-and-ends'> </a>

# Odds and ends

We're now going to work through some more easy but very valuable enhancements to the app. We're going to add:

 * A menu for story statuses. The free-form text field is a bit poor after all. We'll do this first with a hard-wired set of options, and then add the ability to manage the set of available statuses.

 * Add filtering of stories by status to the project page

 * Drag and drop re-ordering of tasks. This effectively gives us prioritisation of tasks.

 * Markdown or textile formatting of stories. This is implemented by changing *one symbol* in the source code.

Off we go.


8d9ebb: [view on github](http://github.com/Hobo/agility-gitorial/commit/8d9ebbc8596234e73e99ba4a5e0717c357794235), [download bb-odds-and-ends.patch](/patches/agility/bb-odds-and-ends.patch)
{: .commit}




<a name='story-status-menu'> </a>

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


6dabd6: [view on github](http://github.com/Hobo/agility-gitorial/commit/6dabd67214397a60ae7346510f487da1cf31222d), [download d6-story-status-menu.patch](/patches/agility/d6-story-status-menu.patch)
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


aecb7b: [view on github](http://github.com/Hobo/agility-gitorial/commit/aecb7b2fc8a1adc6a3f45003a90f99bda3431958), [download 7b-story-status-ajaxified.patch](/patches/agility/7b-story-status-ajaxified.patch)
{: .commit}




<a name='generate-story-status-model'> </a>

## Have a configurable set of statuses

In order to support management of the statuses available, we'll create a StoryStatus model

	$ hobo generate resource story_status name:string


003519: [view on github](http://github.com/Hobo/agility-gitorial/commit/0035192e64316ec0de1e8506ffae14790588668b), [download 19-generate-story-status-model.patch](/patches/agility/19-generate-story-status-model.patch)
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



02d893: [view on github](http://github.com/Hobo/agility-gitorial/commit/02d8938afcceb2aedd8e5533c528645df786273a), [download 93-auto-actions-story-status-controller.patch](/patches/agility/93-auto-actions-story-status-controller.patch)
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
    +  belongs_to :status, :class_name => "StoryStatus", :inverse_of => :story
     
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



83aa75: [view on github](http://github.com/Hobo/agility-gitorial/commit/83aa751f095a73233ce78df8fb6d659e747365b4), [download 75-story-status-belongs-to-story.patch](/patches/agility/75-story-status-belongs-to-story.patch)
{: .commit}




<a name='story-status-model-migration'> </a>

Now run the migration generator

    $ hobo generate migration

You'll see that the migration generator considers this change to be ambiguous. Whenever there are columns removed *and* columns added, the migration generator can't tell whether you're actually removing one column and adding another, or if you are renaming the old column. It's also pretty fussy about what it makes you type. We really don't want to play fast and lose with your precious data, so to confirm that you want to drop the 'status' column, you have to type in full: "drop status".

Once you've done that you'll see that the generated migration includes the creation of the new foreign key and the removal of the old status column.  Press `g` now to generate the migration without running it.


3542c2: [view on github](http://github.com/Hobo/agility-gitorial/commit/3542c29755f7e720506f8a15b213b5f1a7fc08e8), [download c2-story-status-model-migration.patch](/patches/agility/c2-story-status-model-migration.patch)
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



14689e: [view on github](http://github.com/Hobo/agility-gitorial/commit/14689e09848ee6a51cec8cdfc271e98b032d5736), [download 9e-story-status-model-migration-edit.patch](/patches/agility/9e-story-status-model-migration-edit.patch)
{: .commit}




<a name='story-status-model-migration-run'> </a>

Run your modified migration:

    $ rake db:migrate

That's it. The page to manage the story statuses should appear in the main navigation.

Now that we've got more structured statuses, let's do something with them...


349034: [view on github](http://github.com/Hobo/agility-gitorial/commit/349034dfeb95629c9476cd9dc7f5f57e6c4eb35f), [download 34-story-status-model-migration-run.patch](/patches/agility/34-story-status-model-migration-run.patch)
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



78cfd5: [view on github](http://github.com/Hobo/agility-gitorial/commit/78cfd5ad5a75e753e95af5ad696bcb33e8c5389c), [download d5-filtering-stories-by-status-dryml.patch](/patches/agility/d5-filtering-stories-by-status-dryml.patch)
{: .commit}




<a name='filtering-stories-by-status-css'> </a>

To make the filter look right, create a file `app/assets/stylesheets/front/agility-custom-styles.css`

    ::: app/assets/stylesheets/front/agility-custom-styles.css
    @@ -0,0 +1,3 @@
    +.show-page.project .filter {float: left;}
    +.show-page.project .filter form, .show-page.project .filter form div {display: inline;}
    +
    
{: .diff}



ef4ad1: [view on github](http://github.com/Hobo/agility-gitorial/commit/ef4ad11a15e4c6087de205350e753f0a95ae1fd5), [download d1-filtering-stories-by-status-css.patch](/patches/agility/d1-filtering-stories-by-status-css.patch)
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
    +    @stories = @stories.status_is(params[:status]) if params[:status]
         hobo_show
       end
     
     end
    
{: .diff}


Status filtering should now be working.


6ae9d7: [view on github](http://github.com/Hobo/agility-gitorial/commit/6ae9d73e3f15a68b95e3f3199ac122f38aa24a72), [download d7-filtering-stories-by-status-controller.patch](/patches/agility/d7-filtering-stories-by-status-controller.patch)
{: .commit}




<a name='install-acts-as-list'> </a>

# Task re-ordering

We're now going to add the ability to re-order a story's tasks by
drag-and-drop. There's support for this built into Hobo, so there's
not much to do. First we need the `acts_as_list` plugin.  Add

    gem "acts_as_list"

to Gemfile and run

    $ bundle


49f4ce: [view on github](http://github.com/Hobo/agility-gitorial/commit/49f4ce97bb8a611f29a868d28da2c2b19323c4fb), [download ce-install-acts-as-list.patch](/patches/agility/ce-install-acts-as-list.patch)
{: .commit}




<a name='acts-as-list-model-changes'> </a>

Now two changes to our models:

    ::: app/models/story.rb
    @@ -11,11 +11,11 @@
       attr_accessible :title, :body, :status, :project, :project_id, :tasks
     
       belongs_to :project, :inverse_of => :stories, :counter_cache => true
       belongs_to :status, :class_name => "StoryStatus", :inverse_of => :story
     
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



49d8a3: [view on github](http://github.com/Hobo/agility-gitorial/commit/49d8a38a486ac78953860489fc375ba910408493), [download a3-acts-as-list-model-changes.patch](/patches/agility/a3-acts-as-list-model-changes.patch)
{: .commit}




<a name='acts-as-list-migrate'> </a>

The migration generator knows about `acts_as_list`, so you can just
run it and you'll get the new position column on Task.

    $ hobo generate migration

And that's it!


8e09f6: [view on github](http://github.com/Hobo/agility-gitorial/commit/8e09f688d876ea7e3cdcd14f85c0fa73a31321d0), [download f6-acts-as-list-migrate.patch](/patches/agility/f6-acts-as-list-migrate.patch)
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



5fa532: [view on github](http://github.com/Hobo/agility-gitorial/commit/5fa53245f69a40dbf76308163c4c12a72726a631), [download 32-remove-position-from-task-form.patch](/patches/agility/32-remove-position-from-task-form.patch)
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


58738d: [view on github](http://github.com/Hobo/agility-gitorial/commit/58738d1a1e0196a779b04a8b68d7e924d83a8983), [download 8d-fix-task-form-cancel.patch](/patches/agility/8d-fix-task-form-cancel.patch)
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



3d898a: [view on github](http://github.com/Hobo/agility-gitorial/commit/3d898a98993b18fd35244c1d78dfb43a71747e85), [download 8a-markdown-formatting-of-stories.patch](/patches/agility/8a-markdown-formatting-of-stories.patch)
{: .commit}




<a name='add-bluecloth-gem'> </a>

You may need to install the relevant ruby gem: either BlueCloth
(markdown) or RedCloth (textile).   Do this by adding

    gem "bluecloth"

to your Gemfile and then running


    $ bundle install


b1b139: [view on github](http://github.com/Hobo/agility-gitorial/commit/b1b139323614251e52b3e06889af150dfa6cf096), [download 39-add-bluecloth-gem.patch](/patches/agility/39-add-bluecloth-gem.patch)
{: .commit}




<a name='project-belongs-to-user'> </a>

# Project ownership

The next goal for Agility is to move to a full multi-user application, where users can create their own projects and control who has access to them. Rather than make this change in one go, we'll start with a small change that doesn't do much by itself, but is a step in the right direction: making projects be owned by users.

Add the following to the Project model:

    ::: app/models/project.rb
    @@ -11,10 +11,12 @@
     
       has_many :stories, :dependent => :destroy, :inverse_of => :project
     
       children :stories
     
    +  belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :project
    +
       # --- Permissions --- #
     
       def create_permitted?
         acting_user.administrator?
       end
    
{: .diff}


There's a Hobo extension there: `:creator => true` tells Hobo that when creating one of these things, the `owner` association should be automatically set up to be the user doing the create.


7405c5: [view on github](http://github.com/Hobo/agility-gitorial/commit/7405c5d6003e2408980d6d6de3c226671e56b3fb), [download c5-project-belongs-to-user.patch](/patches/agility/c5-project-belongs-to-user.patch)
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



384a25: [view on github](http://github.com/Hobo/agility-gitorial/commit/384a25bc4e76f7e9ab9107bf4ce35c3fa5117457), [download 25-users-have-many-projects.patch](/patches/agility/25-users-have-many-projects.patch)
{: .commit}




<a name='project-permissions'> </a>

How should this affect the permissions? Certain operations on the project should probably be restricted to its owner. We'll use the `owner_is?` helper (that Hobo provides for every `belongs_to` relationship) as it can save an extra database hit. So, edit these permission methods in the Project model:

    ::: app/models/project.rb
    @@ -16,19 +16,19 @@
       belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :project
     
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


0c4c11: [view on github](http://github.com/Hobo/agility-gitorial/commit/0c4c11e0fcc2801a6fc80b4da645a8953a0ec5e9), [download 11-project-permissions.patch](/patches/agility/11-project-permissions.patch)
{: .commit}




<a name='task-assignment-permissions'> </a>

The stories, tasks and task assignments associated with the project
need permissions similar to that of their containing project.  Let's
set their permission to check their containing project:

    ::: app/models/story.rb
    @@ -18,19 +18,19 @@
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



5b7a4f: [view on github](http://github.com/Hobo/agility-gitorial/commit/5b7a4f71894c3c0b2da31ab5c6c2845e70ad7530), [download 4f-task-assignment-permissions.patch](/patches/agility/4f-task-assignment-permissions.patch)
{: .commit}




<a name='project-ownership-migration'> </a>

Run the migration generator to see the effect on the app:

    $ hobo generate migration


89c10d: [view on github](http://github.com/Hobo/agility-gitorial/commit/89c10d6ee53f0f28c2d5c4d3c7caa7e3f733189a), [download 0d-project-ownership-migration.patch](/patches/agility/0d-project-ownership-migration.patch)
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



1917d4: [view on github](http://github.com/Hobo/agility-gitorial/commit/1917d4e94cc355864ff3fa0a1c7206657041cf3c), [download d4-add-your-projects-to-front.patch](/patches/agility/d4-add-your-projects-to-front.patch)
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



a73b68: [view on github](http://github.com/Hobo/agility-gitorial/commit/a73b689adc46d5e610247b6f16862ba78fb641e1), [download 68-project-cards-without-creator-link.patch](/patches/agility/68-project-cards-without-creator-link.patch)
{: .commit}




<a name='generate-project-membership'> </a>

# Granting read access to others

Now that we've got users owning their own projects, it seems wrong that any signed-up user can view any project. On the other hand it wouldn't make any sense to hide the project from everyone. What we need is a way for the project owner to grant others access.

We can model this with a ProjectMembership model that represents access for a specific user and project:

    $ hobo generate resource project_membership


20af0e: [view on github](http://github.com/Hobo/agility-gitorial/commit/20af0e5c90d3231834fa69f12cdf6f331aabec51), [download 0e-generate-project-membership.patch](/patches/agility/0e-generate-project-membership.patch)
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



00073c: [view on github](http://github.com/Hobo/agility-gitorial/commit/00073c709dc6886d78fcaf7fb8d1b6ab20d1b965), [download 3c-project-memberships-tweak-auto-actions.patch](/patches/agility/3c-project-memberships-tweak-auto-actions.patch)
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



c82f2b: [view on github](http://github.com/Hobo/agility-gitorial/commit/c82f2b9376d21df3ccb7121ef0a55163b0811178), [download 2b-project-memberships-add-associations-to-model.patch](/patches/agility/2b-project-memberships-add-associations-to-model.patch)
{: .commit}




<a name='migrate-project-memberships'> </a>

Run the migration generator to have the required foreign keys added to
the database:

    $ hobo g migration


56a7a0: [view on github](http://github.com/Hobo/agility-gitorial/commit/56a7a01ffbc5e634ffbedd35dfca471e08ecbfa6), [download a0-migrate-project-memberships.patch](/patches/agility/a0-migrate-project-memberships.patch)
{: .commit}




<a name='project-memberships-permissions'> </a>

Then permissions -- only the project owner (and admins) can manipulate these project memberships:


b53f95: [view on github](http://github.com/Hobo/agility-gitorial/commit/b53f95bb9707e2b394a94bebae44ccd3f3c0ab9f), [download 95-project-memberships-permissions.patch](/patches/agility/95-project-memberships-permissions.patch)
{: .commit}




<a name='project-has-many-members'> </a>

Let's do the other ends of those two belongs-to associations. In the Project model:

    ::: app/models/project.rb
    @@ -11,10 +11,14 @@
     
       has_many :stories, :dependent => :destroy, :inverse_of => :project
     
       children :stories
     
    +  has_many :memberships, :class_name => "ProjectMembership", :dependent => :destroy, :inverse_of => :project
    +  has_many :members, :through => :memberships, :source => :user
    +
    +  belongs_to :owner, :class_name => "User", :creator => true
       belongs_to :owner, :class_name => "User", :creator => true, :inverse_of => :project
     
       # --- Permissions --- #
     
       def create_permitted?
    
{: .diff}



ef5268: [view on github](http://github.com/Hobo/agility-gitorial/commit/ef52685a9e5070cabd2fd97c20f73d7d89c29470), [download 68-project-has-many-members.patch](/patches/agility/68-project-has-many-members.patch)
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



64d839: [view on github](http://github.com/Hobo/agility-gitorial/commit/64d83928cac2064a42cdd4d5970ddc1a6d80c477), [download 39-user-has-many-joined-projects.patch](/patches/agility/39-user-has-many-joined-projects.patch)
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
    @@ -30,9 +30,9 @@
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



f63258: [view on github](http://github.com/Hobo/agility-gitorial/commit/f63258c8d236dcb21e17408a44e1eddb327e2704), [download 58-view-permission-based-on-project-membership.patch](/patches/agility/58-view-permission-based-on-project-membership.patch)
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


a3bf5b: [view on github](http://github.com/Hobo/agility-gitorial/commit/a3bf5b62a029dab72d5dfa36325ada8dd479afd5), [download 5b-update-project-actions.patch](/patches/agility/5b-update-project-actions.patch)
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
     
       has_many :memberships, :class_name => "ProjectMembership", :dependent => :destroy, :inverse_of => :project
       has_many :members, :through => :memberships, :source => :user
     
       belongs_to :owner, :class_name => "User", :creator => true
    
{: .diff}


Note that view hints are defined in the model.   This is not a great
place for them, but it is better than the alternatives.

It is very common for websites to present information in a hierarchy, and this `children` declaration tells Hobo about the hierarchy of your data. The order is significant; in this example `stories` is the 'main' child relationship, and `memberships` is secondary. The Rapid page generators use this information and place the `stories` collection in the main area of the page, and an aside section will be added for the `memberships`.

Refresh any project page and you should see the collection, which will be empty of course, in a side-bar.


fe21e5: [view on github](http://github.com/Hobo/agility-gitorial/commit/fe21e5b76d552f46ef1eac859a2b8fd4fc550033), [download e5-move-membership-to-sidebar.patch](/patches/agility/e5-move-membership-to-sidebar.patch)
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



2efaaf: [view on github](http://github.com/Hobo/agility-gitorial/commit/2efaaf1e3ab1dd774b39547a00e42daa0b332564), [download af-auto-completion-controller.patch](/patches/agility/af-auto-completion-controller.patch)
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


e13864: [view on github](http://github.com/Hobo/agility-gitorial/commit/e13864e443b2001040944d725bceba9c17930db4), [download 64-auto-completion-form.patch](/patches/agility/64-auto-completion-form.patch)
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



8aa547: [view on github](http://github.com/Hobo/agility-gitorial/commit/8aa547615177fe64415e52f5825973900dc43970), [download 47-removing-members.patch](/patches/agility/47-removing-members.patch)
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



a8c2bc: [view on github](http://github.com/Hobo/agility-gitorial/commit/a8c2bcf312e40572256e07d85c5b2a3266a6b6c1), [download bc-removing-members-2.patch](/patches/agility/bc-removing-members-2.patch)
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


a1386f: [view on github](http://github.com/Hobo/agility-gitorial/commit/a1386f29e5e58260f1e0a33f4508fed8d70b1bcf), [download 6f-fix-front-page.patch](/patches/agility/6f-fix-front-page.patch)
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


bb8669: [view on github](http://github.com/Hobo/agility-gitorial/commit/bb86691037855ccde5d2074ce2892ccd37825ee2), [download 69-granting-write-access-to-others.patch](/patches/agility/69-granting-write-access-to-others.patch)
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


cbc338: [view on github](http://github.com/Hobo/agility-gitorial/commit/cbc338a645ad96020e49ce93f9ff406bd0bbc8d6), [download 38-breaking-out-of-the-box.patch](/patches/agility/38-breaking-out-of-the-box.patch)
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


3fa4aa: [view on github](http://github.com/Hobo/agility-gitorial/commit/3fa4aace67a2dd44f3adb1c4b102eb846a277799), [download aa-install-shoulda-and-factory-girl.patch](/patches/agility/aa-install-shoulda-and-factory-girl.patch)
{: .commit}
