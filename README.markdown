# indexes

This extension adds indexes to the database, which should speed up common queries and provide a more snappy response for page rendering.

The extension is targeted at sites running on Radiant up to version 0.6.9. These indexes were added to the database in version 0.7 of Radiant, so this extension will be of no use if your site is running on version 0.7.0 or later.

## To install

Place this extension in the vendor/extensions directory of your Radiant project. Then run the Rake task:

    rake [production] radiant:extensions:indexes:install

## To uninstall

If you are planning on upgrading your site to run on Radiant 0.7.0 or later, it is advised that you first uninstall this extension. To do so, first run the rake task:

    rake [production] radiant:extensions:indexes:uninstall

Then delete this extension from your vendor extensions directory.