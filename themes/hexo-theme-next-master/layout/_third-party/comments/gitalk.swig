{% if page.comments && theme.gitalk.enable %}

  <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">

  <script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>
  <script src="/js/src/md5.min.js"></script>
   <script type="text/javascript">
        var gitalk = new Gitalk({
          clientID: '{{ theme.gitalk.clientID }}',
          clientSecret: '{{ theme.gitalk.clientSecret }}',
          repo: '{{ theme.gitalk.repo }}',
          id: md5(window.location.pathname),
          owner: '{{ theme.gitalk.owner }}',
          admin: ['{{ theme.gitalk.admin }}'],
          labels: '{{ theme.gitalk.labels }}',
          perPage: {{ theme.gitalk.perPage }},
          pagerDirection: '{{ theme.gitalk.pagerDirection }}',
          createIssueManually: {{ theme.gitalk.createIssueManually }},
          distractionFreeMode: {{ theme.gitalk.distractionFreeMode }},
        })

        gitalk.render('gitalk-container')           
       </script>
{% endif %}