Generators -- manual/generators/user\_model.markdown
{: .document-title}


## Usage

    

    rails generate hobo:user_model [NAME=user] [options]


## Options

    

        [--skip-namespace]                         # Skip namespace (affects only isolated applications)
    -i, [--invite-only]                            # Add features for an invite only website
        [--timestamps]                             # Indicates when to generate timestamps
        [--old-style-hash]                         # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--admin-subsite-name=ADMIN_SUBSITE_NAME]  # Admin Subsite Name
                                                   # Default: admin
        [--activation-email]                       # Send an email to activate the account


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    


      This generator is used by the user_resource generator to generate a
      user model file into app/models.

