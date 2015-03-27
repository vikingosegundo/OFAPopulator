Pod::Spec.new do |s|

  s.name         = "OFAPopulator"
  s.version      = "0.0.3"
  s.summary      = "OFA Populator offers an easy to implement yet powerful way to populate table and collection views."

  s.description  = <<-DESC
                   By implementing section datasources and data fetcher protocol
                   it becomes easy to populate table views and collection views.

                   ```objc
                   OFASectionPopulator *sectionPopulator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                            dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                         cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"Section2"; }
                                                                       cellConfigurator:^(NSNumber *obj, UITableViewCell *cell, NSIndexPath *indexPath)
{
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
    cell.textLabel.backgroundColor = [UIColor clearColor];
}];

sectionPopulator.sectionIndexTitle = ^(NSUInteger section){
    return @"s";
};


self.populator = [[OFAViewPopulator alloc] initWithParentView:self.tableView
                                            sectionPopulators:@[sectionPopulator]];

                   ``
                   DESC

  s.homepage     = "http://vikingosegundo.github.io/ofapopulator"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Manuel Meyer" => "manuel.meyer@goeuro.com" }
  s.social_media_url   = "http://twitter.com/vikingosegundo"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/vikingosegundo/ofapopulator.git", :tag => "0.0.3" }
  s.source_files  = "OFAPopulator/OFA/**/*.*"
  s.public_header_files = "OFAPopulator/OFA/Header/**/*.h"

end
