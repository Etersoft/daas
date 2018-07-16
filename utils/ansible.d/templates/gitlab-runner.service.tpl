[Unit]
Description=GitLab Runner
After=syslog.target network.target
ConditionFileIsExecutable=/usr/local/bin/gitlab-runner

[Service]
StartLimitInterval=5
StartLimitBurst=10
ExecStart=/usr/local/bin/gitlab-runner "run" "--working-directory" "/home/{{project.vstand.user}}" "--config" "/home/{{project.vstand.user}}/.gitlab-runner/config.toml"

Restart=always
RestartSec=120
User={{project.vstand.user}}

[Install]
WantedBy=multi-user.target
