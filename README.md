# Jupyter-Playground

Renamed it Jupyter Playground to accomodate Rust and future languages I want to build content for. 

<a href="https://mybinder.org/v2/gh/jingsta/powershell-playground/master?urlpath=lab" target="_blank">![Binder](https://mybinder.org/badge_logo.svg)</a>

This is the powershell playground. Use this to load up Jupyter notebooks to learn, test, and grab various code snippets to use in your own scripts or notebooks. Please contribute any of your notebooks you think would help others.

| Take me to the | Description |
| ------ | ------ |
| [Free Playground](http://www.powershellplayground.com) | This is the easy button to start hammering out the workbooks without having to mess with docker or making your own local jupyter notebook locally. (Hosted by Mybinder.org) |
| [Notebook Library](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/Microsoft) | My library of notebooks I have made. Please contribute any cool notebooks you have made and share to others!
| [Jupyter Notebook Tutorial Workbooks](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/0%20-%20Tutorial%20with%20Videos) |  The best way to learn is to get your hands dirty. Load up the notebooks yourself or code with me by following the playlist corresponding to the workbook. 
| [Youtube PowerShell Playlist](https://www.youtube.com/watch?v=QPMC0Q_4oug&list=PLM3TOIlrnaI6-XXwBSCB1ae1yyKIjaefq) | Watch me work through the workbooks on Youtube and follow along with the workbooks as I walk through each chapter. 
| [PowerShellBook PDF](http://GoalKicker.com/PowerShellBook) | This tutorial was sourced from the great work done by http://GoalKicker.com/PowerShellBook and the beautiful people in the Stack Overflow community.

## Whats new 
- 7/13/2020 - Added Chapter 11 and Video Tutorial
- 7/3/2020 - Updated Chapter 9 and Added Chapter 10 Tutorial guide with embedded videos [Link to folder here](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/0%20-%20Tutorial%20with%20Videos)
- 7/2/2020 - Added Chapter 8,9 Tutorial guide with embedded videos [Link to folder here](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/0%20-%20Tutorial%20with%20Videos)
- 7/1/2020 - Added Chapter 6,7 Tutorial Guide with embedded videos too [Link to folder here](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/0%20-%20Tutorial%20with%20Videos)
- 6/30/2020 - Added Chapter 3,4, and 5 Tutorial Guide with embedded videos too [Link to folder here](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/0%20-%20Tutorial%20with%20Videos)
- 6/27/2020 - Adding Chapter 2 Tutorial Guide with complimentary explainer videos [Chapter 2 - Variables in Powershell](https://github.com/jingsta/powershell-playground/blob/master/PowerShell/0%20-%20Tutorial%20with%20Videos/Chapter%202%20-%20Variables%20in%20PowerShell.ipynb)
- 6/27/2020 - Added Chapter 1 Tutorial Guide with complimentary videos [Chapter 1 - Getting started with PowerShell](https://github.com/jingsta/powershell-playground/blob/master/PowerShell/0%20-%20Tutorial%20with%20Videos/Chapter%201%20-%20Getting%20started%20with%20PowerShell.ipynb)
- Added [Azure Sentinel Notebooks](https://github.com/jingsta/powershell-playground/tree/master/PowerShell/Microsoft/Security/Azure%20Sentinel) to query Sentinel from powershell via REST API. Tested both Device Code and Personal access key and successfully queried. Still need to be charts. 

## Getting Started

To get started with the playground, click on the launch binder link or goto [PowerShellPlayground.com](http://www.powershellplayground.com). It should load an environment on Mybinders.com which is a free cloud hosted notebook that will clone this repository. 

#### To run your own Jupyter Notebook locally using docker. 
clone the github repo and navigate to the docker folder.
```
- docker build --tag powershellplayground .
- docker run -p 8888:8888 powershellplayground
```

#### Contributing

Please reach out to Jing on LinkedIn if you want to contribute. 

### # Resources
[Dot Net Interactive Github Repo](https://github.com/dotnet/interactive)<br>
[A good Jupyter Base Template written by one of the Powershell Devs @TylerLeonhardt](https://github.com/TylerLeonhardt/JupyterNotebooks-Template)<br>
[Dfinke - Run powershell scripts directly from a Jupyter Notebook file](https://github.com/dfinke/PowerShellNotebook)<br>

#### Authors
 **Jing Nghik** - *Administrator* - [Github](https://github.com/jingsta), [LinkedIn](https://www.linkedin.com/in/TeachJing), [Twitter](https://www.twitter.com/TeachJing)

#### License
This project has adopted the [Microsoft Open Source Code of Conduct](http://microsoft.github.io/codeofconduct). For more information see the [Code of Conduct FAQ](http://microsoft.github.io/codeofconduct/faq.md) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments. 
