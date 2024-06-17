# Docker架构

Docker包括三个基本概念：

* **镜像（Image）**：Docker镜像（Image），就相当于一个root文件系统。比如官方镜像Ubuntu：16.04就包含了完整的一套Ubuntu16.91最小系统的root文件系统。
* **容器（Container）**：镜像（Image）和容器（Container）的关系，就像是面向对象程序设计中的类和实例一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。
* **仓库（Repository）**：仓库可看成一个代码控制中心，用来保存镜像。

Docker使用客户端-服务器（C/S）架构模式，使用远程API来管理和创建Docker容器。
Docker容器通过Docker镜像来创建。
容器和镜像的关系类似于面向对象编程中的对象和类。
<table><tbody><tr>
<th>Docker</th><th>面向对象</th></tr>
<tr>
<td>容器</td><td>对象</td></tr><tr>
<td>镜像</td><td>类</td>
</tr>
</tbody></table>

![alt](https://www.runoob.com/wp-content/uploads/2016/04/576507-docker1.png)

<table>
 <tbody>
<tr><th width="20%">概念</th><th>说明</th></tr>
  <tr>
   <td><p>Docker 镜像(Images)</p></td>
   <td><p>Docker 镜像是用于创建 Docker 容器的模板，比如 Ubuntu 系统。 </p></td>
  </tr>
  <tr>
   <td><p>Docker 容器(Container)</p></td>
   <td><p>容器是独立运行的一个或一组应用，是镜像运行时的实体。</p></td>
  </tr>
  <tr>
   <td><p>Docker 客户端(Client)</p></td>
   <td><p>
Docker 客户端通过命令行或者其他工具使用 Docker SDK (<a href="https://docs.docker.com/develop/sdk/">https://docs.docker.com/develop/sdk/</a>) 与 Docker 的守护进程通信。</p></td>
  </tr>
  <tr>
   <td><p>Docker 主机(Host)</p></td>
   <td><p>一个物理或者虚拟的机器用于执行 Docker  守护进程和容器。</p></td>
  </tr>
  <tr>
   <td><p>Docker Registry</p></td>
   <td><p>Docker 仓库用来保存镜像，可以理解为代码控制中的代码仓库。</p>
<p>Docker Hub(<a href="https://hub.docker.com">https://hub.docker.com</a>) 提供了庞大的镜像集合供使用。</p>
  <p>一个 Docker Registry 中可以包含多个仓库（Repository）；每个仓库可以包含多个标签（Tag）；每个标签对应一个镜像。</p>
<p>通常，一个仓库会包含同一个软件不同版本的镜像，而标签就常用于对应该软件的各个版本。我们可以通过 <span>&lt;仓库名&gt;:&lt;标签&gt;</span> 的格式来指定具体是这个软件哪个版本的镜像。如果不给出标签，将以 <strong>latest</strong> 作为默认标签。</p></td>
  </tr>
  <tr>
   <td><p>Docker Machine</p></td>
   <td><p>Docker Machine是一个简化Docker安装的命令行工具，通过一个简单的命令行即可在相应的平台上安装Docker，比如VirtualBox、 Digital Ocean、Microsoft Azure。</p></td>
  </tr>
 </tbody>
</table>
