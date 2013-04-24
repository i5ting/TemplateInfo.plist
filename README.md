# TemplateInfo.plist

TemplateInfo.plist is ruby gem for create TemplateInfo.plist file.

TemplateInfo.plist file is used in xcode 4 template files.

## Installation

Add this line to your application's Gemfile:

    gem 'TemplateInfo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install TemplateInfo 

## Usage

切换到对应目录：

    $ tif_create
	
默认创建TemplateInfo.plist

	
当然，tif_create也可以接收1个参数，生成的文件名称

    $ tif_create my.plist
	

**Note**

xcode 4的模板目录名是以**.xctemplate**结尾的。如base_ios.xctemplate，如果命名不规范不能执行。
	
	
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## History

v0.0.4：2013-04-24

- 修改了key和string生成问题

	   <key>libs/BeeFramework/MVC/ViewController/Extension/UIViewController+UINavigationBar.m</string>
		   

