c = get_config()

#Export all the notebooks in the current directory to the sphinx_howto format.
c.NbConvertApp.notebooks = ['*.ipynb']

c.NbConvertApp.export_format = 'markdown'

c.NbConvertApp.output_files_dir = '../assets/posts/{notebook_name}_files'
