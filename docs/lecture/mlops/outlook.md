---
title: "Conclusion & Outlook"
---

## Conclusion

With simple tools you can progressively go from a Jupyter Notebook to a professional pipeline

Adding experiment tracking can be done inside a Jupyter Notebook, requiring only little change with a huge impact.
Adding data versioning is similarly simple and can be done with a simple DVC project.
It does require a dedicated storage space though, like a Minio server.

Automating the ML pipeline requires a bit more work, but can be done progressively.
By splitting your notebooks first into logical parts (pre-processing, training, evaluation etc.)
you can progressively automate you pipeline.

Most of this can be done without a specialized infrastructure, although having GPU runners in your CI/CD can simplify the process.

As for the future, just as DevOps became the gold standard for classic development, MLOps will do the same.
For this, think about your data and experiments as code and your models as the binaries and apply the DevOps approach to achieve this.
