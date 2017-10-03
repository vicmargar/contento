defmodule Contento.Mailer.Email do
  import Bamboo.Email
  import ContentoWeb.Gettext

  def welcome_email(user) do
    new_email(
      to: user.email,
      from: "noreply@example.org",
      subject: gettext("Welcome to Contento!"),
      html_body: """
      <h1>#{gettext("Welcome to Contento!")}</h1>
      <p>#{gettext("Your account has been successfully activated and you're ready to start using Contento.")}</p>
      <p>#{gettext("To login to your account follow this link and enter your credentials (email and the password you just setup).")}</p>
      <p>#{gettext("If you have any doubt about how to use Contento visit the following pages to help you out:")}</p>
      <ul>
        <li>
          <a href="#">
            #{gettext("Contento Website")}
          </a>
        </li>
        <li>
          <a href="#">
            #{gettext("Contento Guides")}
          </a>
        </li>
        <li>
          <a href="#">
            #{gettext("Contento Documentation")}
          </a>
        </li>
      </ul>
      <p>#{gettext("We hope you a warm and joyful stay!")}</p>
      <br />
      <p>
        #{gettext("Best regards,")}
        <br />
        <strong>#{gettext("Contento Team")}</strong>
      </p>
      """,
      text_body: """
      #{gettext("Welcome to Contento!")}

      #{gettext("Your account has been successfully activated and you're ready to start using Contento.")}

      #{gettext("To login to your account follow this link and enter your credentials (email and the password you just setup).")}

      #{gettext("If you have any doubt about how to use Contento visit the following pages to help you out:")}

      - #{gettext("Contento Website")}
      - #{gettext("Contento Guides")}
      - #{gettext("Contento Documentation")}

      #{gettext("We hope you a warm and joyful stay!")}

      #{gettext("Best regards,")}
      #{gettext("Contento Team")}
      """
    )
  end

  def activation_email(user, activation_link) do
    new_email(
      to: user.email,
      from: "noreply@example.org",
      subject: gettext("Activate your Contento account!"),
      html_body: """
      <h1>#{gettext("Activate your Contento account!")}</h1>
      <p>#{gettext("Please, activate your Contento account by following this link:")}</p>
      <p>
        <a href="#{activation_link}">#{activation_link}</a>
      </p>
      <br />
      <p>
        #{gettext("Best regards,")}
        <br />
        <strong>#{gettext("Contento Team")}</strong>
      </p>
      """,
      text_body: """
      #{gettext("Activate your Contento account!")}

      #{gettext("Please, activate your Contento account by following this link:")}

      #{activation_link}

      #{gettext("Best regards,")}
      #{gettext("Contento Team")}
      """
    )
  end
end
