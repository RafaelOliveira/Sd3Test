let project = new Project('3DEngine');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addShaders('Sources/Shaders/**');
project.addLibrary('Sd3');
resolve(project);
