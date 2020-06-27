# Powershell-Playground

<a href="https://mybinder.org/v2/gh/jingsta/powershell-playground/master?urlpath=lab" target="_blank">![Binder](https://mybinder.org/badge_logo.svg)</a>

Welcome to the Powershell Playground

This is the powershell playground. Use this to load up notebooks to learn, test, and grab various code snippets to use in your own scripts or notebooks. Please contribute any of your notebooks you think would help others.

## Whats new 
- Added [Azure Sentinel Notebooks](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/Microsoft/Security/Azure%20Sentinel) to query Sentinel from powershell via REST API. Tested both Device Code and Personal access key and successfully queried. Still need to be charts. 

## Getting Started

To get started with the playground, click on the launch binder link or goto [PowerShellPlayground.com](http://www.powershellplayground.com). It should load an environment on Mybinders.com which is a free cloud hosted notebook that will clone this repository. 

To run your own Jupyter Notebook locally using docker. 
- clone the github repo and navigate to the docker folder.
- docker build --tag powershellplayground .
- docker run -p 8888:8888 powershellplayground

## Contributing

Please reach out to Jing on LinkedIn if you want to contribute. 

## Resources
[Dot Net Interactive Github Repo](https://github.com/dotnet/interactive)<br>
[A good base Jupyter Base Template written by one of the Powershell Devs](https://github.com/TylerLeonhardt/JupyterNotebooks-Template)<br>
[Dfinke - Run powershell scripts directly from a Jupyter Notebook file](https://github.com/dfinke/PowerShellNotebook)<br>

## Authors

 **Jing Nghik** - *Administrator* - [Github](https://github.com/jingsta), [LinkedIn](https://www.linkedin.com/in/jnghik)

## License

This project has adopted the [Microsoft Open Source Code of Conduct](http://microsoft.github.io/codeofconduct). For more information see the [Code of Conduct FAQ](http://microsoft.github.io/codeofconduct/faq.md) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments. 
